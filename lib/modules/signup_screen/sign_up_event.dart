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

  SignUpPostEvent({required this.email, required this.name, required this.pass});
}
