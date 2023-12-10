import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelling_app/login/data/auth/fire_auth.dart';
import 'package:travelling_app/login/logic/login_event.dart';
import 'package:travelling_app/login/logic/login_state.dart';

class LoginBLoc extends Bloc<LoginEvent, LoginState> {
  bool isValidEmail = false;
  bool isValidPass = false;
  // final FireDatabase database;
  final Auth auth;

  LoginBLoc({
    required this.auth,
    // required this.database,
  }) : super(LoginInitState()) {
    on<LoginTextChangeEmailEvent>((event, emit) {
      if (event.email.isEmpty) {
        isValidEmail = false;
        emit(LoginErrorEmailState(errorEmail: "khong bo trong emil"));
      } else if (!EmailValidator.validate(event.email)) {
        isValidEmail = false;
        emit(LoginErrorEmailState(errorEmail: "email khong dung dinh dang"));
      } else {
        emit(LoginValidEmailState());
        isValidEmail = true;
      }
    });

    on<LoginTextChangePassEvent>((event, emit) {
      if (event.pass.isEmpty) {
        isValidPass = false;
        emit(LoginErrorPassState(errorPass: 'khong duoc bo trong pass'));
      } else {
        isValidPass = true;
        emit(LoginValidPassState());
      }
    });
    on<LoginSubmitEvent>(
      (event, emit) async {
        emit(LoginLoadingState());
        try {
          await auth.signInWithEmailAndPassword(email: event.email, password: event.password);
          // database.postUserFile(
          //   event.email,
          //   event.password,
          // );
        } on FirebaseAuthException catch (e) {
          showDialog(
            context: event.context,
            builder: (context) {
              return AlertDialog(
                title: Text(e.message.toString()),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Okay"))
                ],
              );
            },
          );
        }
        emit(LoginSuccessState());
      },
    );
  }
}
