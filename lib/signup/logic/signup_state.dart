abstract class SignUpState {}

class SignUpLoadedState extends SignUpState {}

class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpErrorNameState extends SignUpState {
  final String errorName;

  SignUpErrorNameState({required this.errorName});
}

class SignUpErrorEmailState extends SignUpState {
  final String errorEmail;

  SignUpErrorEmailState({required this.errorEmail});
}

class SignUpErrorPassState extends SignUpState {
  final String errorPass;

  SignUpErrorPassState({required this.errorPass});
}

class SignUpErrorRePassState extends SignUpState {
  final String errorRePass;

  SignUpErrorRePassState({required this.errorRePass});
}

class SignUpNameValidState extends SignUpState {}

class SignUpEmailValidState extends SignUpState {}

class SignUpPassValidState extends SignUpState {}

class SignUpRePassValidState extends SignUpState {}
