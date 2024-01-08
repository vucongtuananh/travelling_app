import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String name;
  final String email;

  const UserModel({required this.email, required this.name});

  factory UserModel.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    return UserModel(
      email: snapshot.data()!['email'],
      name: snapshot.data()!['user-name'],
    );
  }
  factory UserModel.fromFireStoreWithQuery(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    return UserModel(
      email: snapshot.data()['email'],
      name: snapshot.data()['user-name'],
    );
  }

  @override
  List<Object?> get props => [name, email];
}
