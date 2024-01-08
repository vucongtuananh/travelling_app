import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String receiverEmail;
  final String message;
  final Timestamp timestamp;

  Message({required this.senderId, required this.senderEmail, required this.receiverEmail, required this.message, required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverEmail': receiverEmail,
      'message': message,
      'timestamp': timestamp,
    };
  }

  factory Message.fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return Message(
      senderId: data['senderId'],
      senderEmail: data['senderEmail'],
      receiverEmail: data['receiverEmail'],
      message: data['message'],
      timestamp: data['timestamp'],
    );
  }
}
