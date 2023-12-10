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

class SignUpTextNameChangeEvent extends SignUpEvent {
  final String name;
  SignUpTextNameChangeEvent({required this.name});
}

class SignUpTextEmailChangeEvent extends SignUpEvent {
  final String email;
  SignUpTextEmailChangeEvent({required this.email});
}

class SignUpTextPassChangeEvent extends SignUpEvent {
  final String pass;
  SignUpTextPassChangeEvent({required this.pass});
}

class SignUpTextRePassChangeEvent extends SignUpEvent {
  final String rePass;
  final String pass;

  SignUpTextRePassChangeEvent({required this.rePass, required this.pass});
}
