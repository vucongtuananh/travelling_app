abstract class SignUpState {}

class SignUpErrorState extends SignUpState {
  final String errorEmail;
  final String errorName;
  final String errorPass;

  SignUpErrorState({required this.errorEmail, required this.errorName, required this.errorPass});
}

class SignUpValidState extends SignUpState {}

class SignUpLoadedState extends SignUpState {}

class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpNotifyState extends SignUpState {
  final String notify;

  SignUpNotifyState({required this.notify});
}

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
