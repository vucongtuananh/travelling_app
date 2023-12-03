import 'package:flutter/widgets.dart';

abstract class LoginEvent {}

class LoginTextChangeEvent extends LoginEvent {
  final String email;
  final String password;

  LoginTextChangeEvent({required this.email, required this.password});
}

class LoginSubmitEvent extends LoginEvent {
  final String email;
  final String password;
  BuildContext context;

  LoginSubmitEvent(this.context, {required this.email, required this.password});
}
