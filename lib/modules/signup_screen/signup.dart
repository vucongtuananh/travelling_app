import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelling_app/data/auth/fire_auth.dart';
import 'package:travelling_app/modules/signup_screen/signup_bloc.dart';
import 'package:travelling_app/widgets/signup_screen/background_signup.dart';
import 'package:travelling_app/widgets/signup_screen/content_box_singup.dart';

final user = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const BackgroundSingUp(),
        Positioned(
          left: 24,
          right: 24,
          top: MediaQuery.of(context).padding.top,
          child: BlocProvider(
              create: (context) => SignUpBloc(
                    auth: Auth(),
                  ),
              child: const ContentBoxSignUp()),
        )
      ]),
    );
  }
}
