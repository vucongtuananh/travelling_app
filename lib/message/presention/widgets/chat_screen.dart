import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/message/data/sources/message_service.dart';
import 'package:travelling_app/message/data/models/message.dart';
import 'package:travelling_app/message/data/sources/notification_service.dart';
import 'package:travelling_app/own/data/user_info_service.dart';
import 'package:travelling_app/signup/data/models/user.dart';

class ChatScreen extends StatefulWidget {
  final UserModel receiver;
  const ChatScreen({
    super.key,
    required this.receiver,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  UserInforService _inforService = UserInforService();
  late final UserModel currentUser;
  final TextEditingController _chatController = TextEditingController();
  final MessageService _messageService = MessageService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final NotificationService _notificationService = NotificationService();
  late final Stream<QuerySnapshot<Map<String, dynamic>>>? stream;

  void sendMessage(BuildContext context) async {
    final message = _chatController.text;
    if (message.trim().isNotEmpty) {
      _chatController.clear();
      FocusScope.of(context).unfocus();
      await _messageService.sendMessage(widget.receiver.uid, message).then((value) => _notificationService.sendPushNotify(
            msg: message,
            receiver: widget.receiver,
            sender: currentUser,
          ));
    }
  }

  getCurrentUser() async {
    currentUser = await _inforService.getUserInfor();
  }

  @override
  void initState() {
    super.initState();

    stream = _messageService.getMessages(
      _firebaseAuth.currentUser!.uid.toString(),
      widget.receiver.uid,
    );
    // _notificationService.receiveNotify();
    getCurrentUser();
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiver.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            Expanded(
              child: _buildMessageList(),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
            child: TextField(
          controller: _chatController,
          decoration: const InputDecoration(
            hintText: "Type a message",
            border: OutlineInputBorder(),
          ),
        )),
        IconButton(onPressed: () => sendMessage(context), icon: const Icon(Icons.send)),
      ],
    );
  }

  Widget _buildMessageListItem(QueryDocumentSnapshot documentSnapshot) {
    var e = documentSnapshot as QueryDocumentSnapshot<Map<String, dynamic>>;
    var data = Message.fromJson(e.data());
    var isMe = (data.senderId == _firebaseAuth.currentUser!.uid);
    var alignment = isMe ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      // color: Colors.amber,
      alignment: alignment,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          isMe
              ? const SizedBox()
              : Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    color: mainColor,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: widget.receiver.urlAvatar == ""
                      ? const Icon(Icons.person)
                      : Image.network(
                          widget.receiver.urlAvatar!,
                          fit: BoxFit.cover,
                        ),
                ),
          Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: isMe ? mainColor : grayBlurColor,
                  borderRadius: isMe
                      ? const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomLeft: Radius.circular(20))
                      : const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
              child: Text(data.content)),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error : ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasData) {
          return ListView(
            reverse: true,
            children: snapshot.data!.docs.map((e) => _buildMessageListItem(e)).toList(),
          );
        }
        return const Text("Kh co data");
      },
    );
  }
}
