import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelling_app/signup/data/models/user.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getUser() async {
    final List<UserModel> list = [];
    await _firestore.collection("user").get().then((value) {
      for (var a in value.docs) {
        list.add(UserModel.fromJson(a.data()));
      }
    });
    return list;
  }
}
