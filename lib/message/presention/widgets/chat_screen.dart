import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/message/data/message_service.dart';
import 'package:travelling_app/message/data/models/message.dart';

class ChatScreen extends StatefulWidget {
  final String receiverEmail;
  final String receiverName;
  const ChatScreen({super.key, required this.receiverEmail, required this.receiverName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _chatController = TextEditingController();
  final MessageService _messageService = MessageService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_chatController.text.isNotEmpty) {
      await _messageService.sendMessage(widget.receiverEmail, _chatController.text);
      _chatController.clear();
    }
  }

  void setUpfcm() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();

    final token = await fcm.getToken();
    print(token);
  }

  @override
  void initState() {
    super.initState();
    setUpfcm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverName),
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
        IconButton(onPressed: sendMessage, icon: const Icon(Icons.send)),
      ],
    );
  }

  Widget _buildMessageListItem(QueryDocumentSnapshot documentSnapshot) {
    var e = documentSnapshot as QueryDocumentSnapshot<Map<String, dynamic>>;
    var data = Message.fromFirestore(e);
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
              : CircleAvatar(
                  backgroundColor: mainColor,
                  child: FittedBox(child: Text(data.senderEmail)),
                ),
          Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isMe ? mainColor : grayBlurColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(data.message)),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _messageService.getMessages(widget.receiverEmail, _firebaseAuth.currentUser!.email.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error : ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          reverse: true,
          children: snapshot.data!.docs.map((e) => _buildMessageListItem(e)).toList(),
        );
      },
    );
  }
}
