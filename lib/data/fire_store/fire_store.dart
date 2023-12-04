import 'package:cloud_firestore/cloud_firestore.dart';

final firebaseStorage = FirebaseFirestore.instance;

class FireStoreData {
  final String currentUserId;
  FireStoreData({required this.currentUserId});

  postUser({required String name, required String email, required String password}) async {
    await firebaseStorage.collection("user").doc(currentUserId).set({"user-name": name, "email": email, "password": password});
  }
}
