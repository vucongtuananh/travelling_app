import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelling_app/data/auth/fire_auth.dart';
import 'package:travelling_app/modules/signup_screen/sign_up_event.dart';
import 'package:travelling_app/modules/signup_screen/signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  bool isValidName = false;
  bool isValidEmail = false;
  bool isValidPass = false;
  final Auth auth;

  SignUpBloc({required this.auth}) : super(SignUpInitialState()) {
    on<SignUpTextChangeEvent>((event, emit) {
      if (event.name.trim().isEmpty) {
        isValidName = false;
        emit(SignUpErrorState(errorEmail: "", errorName: "khong duoc bo trong ten", errorPass: ""));
      } else if (event.email.isEmpty) {
        isValidName = true;
        isValidEmail = false;
        emit(SignUpErrorState(errorEmail: "khong duoc bo trong email", errorName: "", errorPass: ""));
      } else if (!EmailValidator.validate(event.email)) {
        emit(SignUpErrorState(errorEmail: "email khong dung dinh dang", errorName: "", errorPass: ""));
      } else if (event.pass.isEmpty) {
        isValidEmail = true;
        emit(SignUpErrorState(errorEmail: "", errorName: "", errorPass: "khong duoc de trong pass"));
      } else if (event.pass.length < 6) {
        emit(SignUpErrorState(errorEmail: "", errorName: "", errorPass: "pass qua ngan"));
      } else {
        isValidPass = true;
        emit(SignUpValidState());
      }
    });

    on<SignUpPostEvent>((event, emit) async {
      emit(SignUpLoadingState());
      try {
        print("dang dang ki");
        await auth.signUpWithEmailAndPassword(email: event.email, password: event.pass);
      } on FirebaseAuthException catch (message) {
        // emit(SignUpNotifyState(notify: message.toString()));

        showDialog(
          context: event.context,
          builder: (context) {
            return AlertDialog(
              title: Text(message.message.toString()),
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

      emit(SignUpLoadedState());
    });
  }
}
