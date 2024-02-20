import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String email;
  final String pass;
  final String uid;
  final String name;
  final String? urlAvatar;
  const UserModel({
    required this.email,
    required this.pass,
    required this.uid,
    required this.name,
    required this.urlAvatar,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'uid': uid,
      'name': name,
      'password': pass,
      'urlAvatar': urlAvatar,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'],
        name: json['name'],
        pass: json['password'],
        uid: json['uid'],
        urlAvatar: json['urlAvatar'],
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        email,
        pass,
        uid,
        name,
        urlAvatar,
      ];
}
