import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelling_app/login/data/auth/fire_auth.dart';
import 'package:travelling_app/home/data/fire_store/fire_store.dart';
import 'package:travelling_app/main.dart';
import 'package:travelling_app/signup/logic/sign_up_event.dart';
import 'package:travelling_app/signup/logic/signup_state.dart';
import 'package:bloc/bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  bool isValidName = false;
  bool isValidEmail = false;
  bool isValidPass = false;
  bool isValidRePass = false;
  bool _isError = false;
  final Auth auth;
  SignUpBloc({
    required this.auth,
  }) : super(SignUpInitialState()) {
    on<SignUpTextNameChangeEvent>((event, emit) {
      if (event.name.trim().isEmpty) {
        isValidName = false;
        emit(SignUpErrorNameState(errorName: "khong duoc bo trong ten"));
      } else {
        isValidName = true;
        emit(SignUpNameValidState());
      }
    });
    on<SignUpTextEmailChangeEvent>((event, emit) {
      if (event.email.isEmpty) {
        isValidEmail = false;
        emit(SignUpErrorEmailState(errorEmail: "khong bo trong email"));
      } else if (!EmailValidator.validate(event.email)) {
        isValidEmail = false;
        emit(SignUpErrorEmailState(errorEmail: "email khong dung dinh dang"));
      } else {
        isValidEmail = true;
        emit(SignUpEmailValidState());
      }
    });
    on<SignUpTextPassChangeEvent>((event, emit) {
      if (event.pass.isEmpty) {
        isValidPass = false;
        emit(SignUpErrorPassState(errorPass: "khong duoc de trong pass"));
      } else if (event.pass.length < 6) {
        isValidPass = false;
        emit(SignUpErrorPassState(errorPass: "pass qua ngan"));
      } else {
        isValidPass = true;
        emit(SignUpPassValidState());
      }
    });
    on<SignUpTextRePassChangeEvent>((event, emit) {
      if (event.rePass != event.pass) {
        isValidRePass = false;
        emit(SignUpErrorRePassState(errorRePass: "mat khau khong trung khop"));
      } else {
        isValidRePass = true;
        emit(SignUpRePassValidState());
      }
    });
    on<SignUpPostEvent>((event, emit) async {
      emit(SignUpLoadingState());
      try {
        await auth.signUpWithEmailAndPassword(email: event.email, password: event.pass);
        showDialog(
          context: event.context,
          builder: (context) {
            return AlertDialog(
              title: Text("Ban da dang ki thanh cong"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyApp(),
                          ));
                    },
                    child: Text("Okay"))
              ],
            );
          },
        );
        _isError = false;
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
        _isError = true;
      }
      if (!_isError) {
        final fireStoreData = FireStoreData(currentUserId: auth.currentUser!.uid);
        await fireStoreData.postUser(name: event.name, email: event.email, password: event.pass, uid: auth.currentUser!.uid);

        await fireStoreData.postData(
          id1: "1",
          describe:
              "What is Redfish Lake known for?\nRedfish Lake is the final stop on the longest Pacific salmon run in North America,\n which requires long-distance swimmers, such as Sockeye and Chinook Salmon,\n to over miles upstream to return to their spawning grounds.\nRedfish Lake is an alpine lake in Custer County,aho,  south of Stanley.\n It is the largest lake within the Sawtooth National Recreation Area.",
          img: "https://ak-d.tripcdn.com/images/10041c000001dadviFB7A.jpg",
          location: "Hà Nội",
          price: 50,
          rate: 4.5,
          title: "RedFish River",
        );
        await fireStoreData.postData(
          id1: "2",
          describe:
              "What is Redfish Lake known for?\nRedfish Lake is the final stop on the longest Pacific salmon run in North America,\n which requires long-distance swimmers, such as Sockeye and Chinook Salmon,\n to over miles upstream to return to their spawning grounds.\nRedfish Lake is an alpine lake in Custer County,aho,  south of Stanley.\n It is the largest lake within the Sawtooth National Recreation Area.",
          img: "https://ak-d.tripcdn.com/images/10041c000001dadviFB7A.jpg",
          location: "Idaho",
          price: 50,
          rate: 4.5,
          title: "Conditional Lake",
        );
        await fireStoreData.postData(
          id1: "3",
          describe:
              "What is Redfish Lake known for?\nRedfish Lake is the final stop on the longest Pacific salmon run in North America,\n which requires long-distance swimmers, such as Sockeye and Chinook Salmon,\n to over miles upstream to return to their spawning grounds.\nRedfish Lake is an alpine lake in Custer County,aho,  south of Stanley.\n It is the largest lake within the Sawtooth National Recreation Area.",
          img: "https://ak-d.tripcdn.com/images/10041c000001dadviFB7A.jpg",
          location: "Thái Bình",
          price: 50,
          rate: 4.5,
          title: "Phuzi Mountain",
        );
        await fireStoreData.postData(
          id1: "4",
          describe:
              "What is Redfish Lake known for?\nRedfish Lake is the final stop on the longest Pacific salmon run in North America,\n which requires long-distance swimmers, such as Sockeye and Chinook Salmon,\n to over miles upstream to return to their spawning grounds.\nRedfish Lake is an alpine lake in Custer County,aho,  south of Stanley.\n It is the largest lake within the Sawtooth National Recreation Area.",
          img: "https://ak-d.tripcdn.com/images/10041c000001dadviFB7A.jpg",
          location: "Đà Nẵng",
          price: 50,
          rate: 4.5,
          title: "DongChau Beach",
        );
      }
      emit(SignUpLoadedState());

      // fireStoreData.postUser(name: event.name, email: event.email, password: event.pass);
    });
  }
}
