import 'package:flutter/widgets.dart';

abstract class SignUpEvent {}

class SignUpTextChangeEvent extends SignUpEvent {
  final String name;
  final String email;
  final String pass;

  SignUpTextChangeEvent({required this.email, required this.name, required this.pass});
}

class SignUpPostEvent extends SignUpEvent {
  final String name;
  final String email;
  final String pass;
  BuildContext context;

  SignUpPostEvent(this.context, {required this.email, required this.name, required this.pass});
}
