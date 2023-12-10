import 'package:flutter/widgets.dart';

abstract class LoginEvent {}

class LoginTextChangeEmailEvent extends LoginEvent {
  final String email;

  LoginTextChangeEmailEvent({required this.email});
}

class LoginTextChangePassEvent extends LoginEvent {
  final String pass;

  LoginTextChangePassEvent({required this.pass});
}

class LoginSubmitEvent extends LoginEvent {
  final String email;
  final String password;
  BuildContext context;

  LoginSubmitEvent(this.context, {required this.email, required this.password});
}
