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
  const ChatScreen({super.key, required this.receiverId, required this.receiverName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _chatController = TextEditingController();
  final MessageService _messageService = MessageService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage(BuildContext context) async {
    if (_chatController.text.isNotEmpty) {
      await _messageService.sendMessage(widget.receiverId, _chatController.text);
      _chatController.clear();
      FocusScope.of(context).unfocus();
    }
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
              : CircleAvatar(
                  backgroundColor: mainColor,
                  child: FittedBox(child: Text(data.senderId)),
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
      stream: _messageService.getMessages(
        _firebaseAuth.currentUser!.uid.toString(),
        widget.receiverId,
      ),
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
        return Text("Kh co data");
      },
    );
  }
}
