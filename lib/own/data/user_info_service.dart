import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:travelling_app/home/data/fire_store/fire_store.dart';
import 'package:travelling_app/signup/data/models/user.dart';

class UserInforService {
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  Future<UserModel> getUserInfor() async {
    late UserModel user;
    await firebaseStorage.collection("user").doc(currentUserId).get().then((value) {
      user = UserModel.fromJson(value.data()!);
    });
    return user;
  }

  Future<void> changeUserInfor(
    String value,
    String? imgUrl,
  ) async {
    await FirebaseFirestore.instance.collection("user").doc(currentUserId).update({"name": value, "urlAvatar": imgUrl});
  }

  Future<String> pushAndGetUrlImage(File file) async {
    var fireStorage = FirebaseStorage.instance.ref().child('user_image').child('$currentUserId.jpg');
    await fireStorage.putFile(file);
    final imgUrl = await fireStorage.getDownloadURL();
    return imgUrl;
  }
}
