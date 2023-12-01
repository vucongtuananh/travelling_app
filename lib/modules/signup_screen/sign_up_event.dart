abstract class SignUpEvent {}

class SignUpNameTextChangeEvent extends SignUpEvent {
  final String userName;

  SignUpNameTextChangeEvent({required this.userName});
}

class SignUpEmailTextChangeEvent extends SignUpEvent {
  final String email;

  SignUpEmailTextChangeEvent({required this.email});
}

class SignUpPassTextChangeEvent extends SignUpEvent {
  final String pass;

  SignUpPassTextChangeEvent({required this.pass});
}
