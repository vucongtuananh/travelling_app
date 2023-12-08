import 'package:firebase_auth/firebase_auth.dart';

abstract class TabEvent {}

class TabEventIn extends TabEvent {
  final User user;
  TabEventIn({required this.user});
}
