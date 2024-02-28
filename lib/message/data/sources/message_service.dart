import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelling_app/message/data/models/message.dart';

class MessageService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //send message
  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final DateTime timestamp = DateTime.now();

    Message _newMessage = Message(senderId: currentUserId, receiverId: receiverId, sentTime: timestamp, content: message);
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");
    await _firestore.collection("chat_room").doc(chatRoomId).collection("message").add(
          _newMessage.toJson(),
        );
  }

  //get message
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore.collection("chat_room").doc(chatRoomId).collection("message").orderBy('sentTime', descending: true).snapshots();
  }
}
