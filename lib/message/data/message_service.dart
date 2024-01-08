import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelling_app/message/data/models/message.dart';

class MessageService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //send message
  Future<void> sendMessage(String receiverEmail, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message _newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverEmail: receiverEmail,
      message: message,
      timestamp: timestamp,
    );
    List<String> ids = [currentUserEmail, receiverEmail];
    ids.sort();
    String chatRoomId = ids.join("_");
    await _firestore.collection("chat_room").doc(chatRoomId).collection("message").add(
          _newMessage.toMap(),
        );
  }

  //get message
  Stream<QuerySnapshot> getMessages(String userEmail, String otherUserEmail) {
    List<String> ids = [userEmail, otherUserEmail];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore.collection("chat_room").doc(chatRoomId).collection("message").orderBy('timestamp', descending: true).snapshots();
  }
}
