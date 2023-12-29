import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelling_app/login/data/auth/fire_auth.dart';
import 'package:travelling_app/signup/logic/signup_bloc.dart';
import 'package:travelling_app/signup/presentation/widgets/background_signup.dart';
import 'package:travelling_app/signup/presentation/widgets/content_box_singup.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(children: [
          const BackgroundSingUp(),
          Positioned(
            left: 24.w,
            right: 24.w,
            top: 13.h,
            child: BlocProvider(
                create: (context) => SignUpBloc(
                      auth: Auth(),
                    ),
                child: const ContentBoxSignUp()),
          )
        ]),
      ),
    );
  }
}
