import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/message/data/message_service.dart';
import 'package:travelling_app/message/data/models/message.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;
  final String? receiverAvt;
  const ChatScreen({super.key, required this.receiverId, required this.receiverName, required this.receiverAvt});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _chatController = TextEditingController();
  final MessageService _messageService = MessageService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  late final Stream<QuerySnapshot<Map<String, dynamic>>>? stream;

  void sendMessage(BuildContext context) async {
    final message = _chatController.text;
    if (message.trim().isNotEmpty) {
      _chatController.clear();
      FocusScope.of(context).unfocus();
      await _messageService.sendMessage(widget.receiverId, message);
    }
  }

  @override
  void initState() {
    super.initState();
    stream = _messageService.getMessages(
      _firebaseAuth.currentUser!.uid.toString(),
      widget.receiverId,
    );
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
                  child: widget.receiverAvt == ""
                      ? const Icon(Icons.person)
                      : Image.network(
                          widget.receiverAvt!,
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
