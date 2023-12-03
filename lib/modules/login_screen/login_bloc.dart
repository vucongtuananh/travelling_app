import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelling_app/data/auth/fire_auth.dart';
import 'package:travelling_app/modules/login_screen/login_event.dart';
import 'package:travelling_app/modules/login_screen/login_state.dart';

class LoginBLoc extends Bloc<LoginEvent, LoginState> {
  bool isValidEmail = false;
  // final FireDatabase database;
  final Auth auth;

  LoginBLoc({
    required this.auth,
    // required this.database,
  }) : super(LoginInitState()) {
    on<LoginTextChangeEvent>(
      (event, emit) {
        if (event.email.isEmpty) {
          isValidEmail = false;
          emit(LoginErrorState(errorEmail: "khong bo trong emil", errorPassword: ""));
        } else if (!EmailValidator.validate(event.email)) {
          isValidEmail = false;
          emit(LoginErrorState(errorEmail: "email khong dung dinh dang", errorPassword: ""));
        } else if (event.password.isEmpty) {
          emit(LoginErrorState(errorEmail: "", errorPassword: "khong bo trong pass"));
          isValidEmail = true;
        } else {
          emit(LoginValidState());
          isValidEmail = true;
        }
      },
    );
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
