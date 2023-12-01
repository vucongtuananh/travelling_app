import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelling_app/modules/signup_screen/sign_up_event.dart';
import 'package:travelling_app/modules/signup_screen/signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  bool isValidName = false;
  bool isValidEmail = false;
  bool isValidPass = false;

  SignUpBloc() : super(SignUpInitialState()) {
    on<SignUpNameTextChangeEvent>((event, emit) {
      if (event.userName.isEmpty) {
        isValidName = false;
        emit(SignUpErrorUserNameState(
          errorName: "khong duoc de trong ten",
        ));
      } else {
        emit(SingUpValidNameState());
        isValidName = true;
      }
    });
    on<SignUpEmailTextChangeEvent>((event, emit) {
      if (event.email.isEmpty) {
        isValidEmail = false;
        emit(SignUpErrorEmailState(
          errorEmail: "khong duoc de trong email",
        ));
      } else if (!EmailValidator.validate(event.email)) {
        isValidEmail = false;
        emit(SignUpErrorEmailState(errorEmail: "email khong dung dinh dang"));
      } else {
        emit(SingUpValidEmailState());
        isValidEmail = true;
      }
    });
    on<SignUpPassTextChangeEvent>((event, emit) {
      if (event.pass.isEmpty) {
        isValidPass = false;
        emit(SignUpErrorPassState(
          errorPass: "khong duoc de trong pass",
        ));
      } else if (event.pass.trim().length < 6) {
        isValidPass = false;
        emit(SignUpErrorPassState(errorPass: "Mat khau qua ngan"));
      } else {
        emit(SingUpValidPassState());
        isValidPass = true;
      }
    });
  }

  bool isValid() {
    return isValidName && isValidEmail && isValidPass;
  }
}
