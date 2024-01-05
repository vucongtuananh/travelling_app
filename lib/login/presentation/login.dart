import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelling_app/login/data/auth/fire_auth.dart';
import 'package:travelling_app/login/logic/login_bloc.dart';
import 'package:travelling_app/login/presentation/widgets/background_login.dart';
import 'package:travelling_app/login/presentation/widgets/content_box_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
      child: Stack(
        children: [
          const BackgroundLogin(),
          Positioned(
              left: 24.w,
              right: 24.w,
              bottom: 24.h,
              child: BlocProvider(
                  create: (context) => LoginBLoc(
                        auth: Auth(),
                        // database: FireDatabase(
                        //   Auth().currentUser!.uid,
                        // ),
                      ),
                  child: const ContentBoxLogin())),
        ],
      ),
    ));
  }
}
