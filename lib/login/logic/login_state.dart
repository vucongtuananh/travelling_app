abstract class LoginState {}

class LoginInitState extends LoginState {}

class LoginErrorState extends LoginState {
  final String errorEmail;
  final String errorPassword;

  LoginErrorState({required this.errorEmail, required this.errorPassword});
}

class LoginValidState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}
