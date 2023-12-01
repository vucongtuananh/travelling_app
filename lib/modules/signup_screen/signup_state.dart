abstract class SignUpState {}

class SignUpErrorState extends SignUpState {
  final String errorEmail;
  final String errorName;
  final String errorPass;

  SignUpErrorState({required this.errorEmail, required this.errorName, required this.errorPass});
}

class SingUpValidState extends SignUpState {}

class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}
