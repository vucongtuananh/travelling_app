import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travelling_app/message/data/message_service.dart';

class ChatScreen extends StatefulWidget {
  final String receiverEmail;

  const ChatScreen({super.key, required this.receiverEmail});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
            child: TextField(
          controller: _chatController,
        )),
        IconButton(onPressed: sendMessage, icon: const Icon(Icons.send)),
      ],
    );
  }

  Widget _buildMessageListItem(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid) ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Column(
        children: [
          Text(data['senderEmail']),
          Text(data['message']),
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
          return const CircularProgressIndicator();
        }
        return ListView(
          children: snapshot.data!.docs.map((e) => _buildMessageListItem(e)).toList(),
        );
      },
    );
  }
}
