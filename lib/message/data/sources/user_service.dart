import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelling_app/own/data/user_model.dart';
import 'package:travelling_app/signup/data/models/user.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getUser() async {
    List<UserModel> list = [];
    await _firestore.collection("user").snapshots(includeMetadataChanges: true).listen((users) {
      list = users.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
    });
    return list;
  }
}
