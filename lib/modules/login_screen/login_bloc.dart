import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelling_app/modules/login_screen/login_event.dart';
import 'package:travelling_app/modules/login_screen/login_state.dart';

class LoginBLoc extends Bloc<LoginEvent, LoginState> {
  bool isValidEmail = false;

  LoginBLoc() : super(LoginInitState()) {
    on<LoginTextChangeEvent>(
      (event, emit) {
        if (event.email.isEmpty) {
          emit(LoginErrorState(errorEmail: "khong bo trong emil", errorPassword: ""));
        } else if (!EmailValidator.validate(event.email)) {
          emit(LoginErrorState(errorEmail: "email khong dung dinh dang", errorPassword: ""));
        } else if (event.password.isEmpty) {
          emit(LoginErrorState(errorEmail: "", errorPassword: "khong bo trong pass"));
          isValidEmail = true;
        } else if (event.password.trim().length < 6) {
          emit(LoginErrorState(errorEmail: "", errorPassword: "pass qua ngan"));
          isValidEmail = true;
        } else {
          emit(LoginValidState());
          isValidEmail = true;
        }
      },
    );
    on<LoginSubmitEvent>(
      (event, emit) {
        emit(LoginSuccessState());
      },
    );
  }
}
