import 'package:flutter/material.dart';
import 'package:travelling_app/widgets/login_screen/background_login.dart';
import 'package:travelling_app/widgets/login_screen/content_box_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const BackgroundLogin(),
        Positioned(
            top: MediaQuery.of(context).padding.top,
            //this widget help me to padding the text a space that equal the heigh of status bar of phone
            left: 24,
            right: 24,
            child: const ContentBoxLogin()),
      ],
    ));
  }
}
