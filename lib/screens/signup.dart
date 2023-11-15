import 'package:flutter/material.dart';
import 'package:travelling_app/widgets/signup_screen/background_signup.dart';
import 'package:travelling_app/widgets/signup_screen/content_box_singup.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [const BackgroundSingUp(), Positioned(left: 24, right: 24, top: MediaQuery.of(context).padding.top, child: const ContentBoxSignUp())]),
    );
  }
}
