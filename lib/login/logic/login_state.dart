abstract class LoginState {}

class LoginInitState extends LoginState {}

class LoginErrorEmailState extends LoginState {
  final String errorEmail;

  LoginErrorEmailState({
    required this.errorEmail,
  });
}

class LoginErrorPassState extends LoginState {
  final String errorPass;

  LoginErrorPassState({required this.errorPass});
}

class LoginValidPassState extends LoginState {}

class LoginValidEmailState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}
