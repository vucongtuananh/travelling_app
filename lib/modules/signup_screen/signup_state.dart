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
