import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/login/logic/login_bloc.dart';
import 'package:travelling_app/login/logic/login_event.dart';
import 'package:travelling_app/login/logic/login_state.dart';
import 'package:travelling_app/signup/presentation/signup.dart';

class ContentBoxLogin extends StatefulWidget {
  const ContentBoxLogin({super.key});

  @override
  State<ContentBoxLogin> createState() => _ContentBoxLoginState();
}

class _ContentBoxLoginState extends State<ContentBoxLogin> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  bool _isHidePass = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        header(context),
        SizedBox(height: 17.h),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: 342.w,
            height: 609.h,
            decoration: const BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1), borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                SizedBox(
                  height: 49.h,
                ),
                SizedBox(width: 208.w, height: 208.h, child: Image.asset("$imagePathLdpi/icon_earth.png")),
                SizedBox(
                  height: 30.h,
                ),
                formLogin(context),
                SizedBox(
                  height: 20.h,
                ),
                handleInput(context),
                SizedBox(
                  height: 30.h,
                ),
                signInBtn(context),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
        signInByOtherWay(),
        SizedBox(
          height: 24.h,
        ),
        signUp(context)
      ],
    );
  }

  Widget header(BuildContext context) {
    return Text("Welcome Back!",
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700, fontSize: 25.sp, color: Theme.of(context).colorScheme.onPrimary));
  }

  Row signUp(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an Account?",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: whiteColor,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignUpScreen(),
                ));
          },
          child: Text(
            " Sign up here",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: whiteColor, fontWeight: FontWeight.w700, fontSize: 12, decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

  formLogin(BuildContext context) => Form(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            height: 45.h,
            width: double.infinity,
            decoration: const BoxDecoration(color: mainColor, borderRadius: BorderRadius.all(Radius.circular(30))),
            alignment: Alignment.center,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 17.5.w,
                  height: 14.h,
                  child: SvgPicture.asset(
                    "$imagePathLdpi/email_icon.svg",
                    color: const Color(0xffE9E9E9),
                  ),
                ),
                SizedBox(
                  width: 10.h,
                ),
                Expanded(
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: _emailController,
                    onChanged: (value) {
                      context.read<LoginBLoc>().add(LoginTextChangeEmailEvent(email: _emailController.text));
                    },
                    cursorColor: const Color(0xffFFFFFF),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15.sp, color: Theme.of(context).colorScheme.onPrimary),
                    decoration: const InputDecoration(
                        // contentPadding: const EdgeInsets.only(bottom: 4),
                        // fillColor: Theme.of(context).colorScheme.onPrimaryContainer,
                        border: InputBorder.none),
                  ),
                ),
                BlocBuilder<LoginBLoc, LoginState>(
                  builder: (context, state) {
                    if (context.read<LoginBLoc>().isValidEmail) {
                      return SizedBox(width: 15.w, height: 15.h, child: SvgPicture.asset("$imagePathLdpi/check.svg"));
                    } else {
                      return const SizedBox();
                    }
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          BlocBuilder<LoginBLoc, LoginState>(
            builder: (context, state) {
              if (state is LoginErrorEmailState) {
                return Text(
                  state.errorEmail,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.red, fontSize: 10.sp),
                );
              }
              return const SizedBox();
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            width: double.infinity,
            height: 45.h,
            decoration: BoxDecoration(border: Border.all(color: const Color(0xff008FA0)), borderRadius: BorderRadius.circular(30)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 16.w,
                  height: 21.h,
                  child: SvgPicture.asset(
                    "$imagePathLdpi/lock_icon.svg",
                    color: grayColor,
                  ),
                ),
                SizedBox(
                  width: 10.h,
                ),
                Expanded(
                  child: TextFormField(
                    controller: _passController,
                    onChanged: (value) {
                      // _cubit.checkPass(_passController.text);
                      context.read<LoginBLoc>().add(LoginTextChangePassEvent(pass: _passController.text));
                    },
                    obscureText: _isHidePass,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: mainColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isHidePass = !_isHidePass;
                            });
                          },
                          child: const Icon(Icons.remove_red_eye)),
                      // contentPadding: const EdgeInsets.only(bottom: 4),
                      fillColor: Theme.of(context).colorScheme.onPrimaryContainer,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          BlocBuilder<LoginBLoc, LoginState>(
            builder: (context, state) {
              if (state is LoginErrorPassState) {
                return Text(
                  state.errorPass,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.red, fontSize: 10.sp),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ));

  signInByOtherWay() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(color: whiteColor, borderRadius: BorderRadius.circular(45)),
              child: Image.asset("$imagePathLdpi/google.png")),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(color: whiteColor, borderRadius: BorderRadius.circular(45)),
              child: Image.asset("$imagePathLdpi/facebook.png")),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(color: whiteColor, borderRadius: BorderRadius.circular(45)),
              child: Image.asset("$imagePathLdpi/apple.png")),
        ],
      );
  handleInput(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 11.w,
                  height: 11.h,
                  decoration: BoxDecoration(border: Border.all(color: Theme.of(context).colorScheme.primary)),
                  child: Icon(
                    Icons.check,
                    color: Theme.of(context).colorScheme.onBackground,
                    size: 12.dg,
                  ),
                ),
              ),
              SizedBox(
                width: 6.w,
              ),
              Text(
                "Remember me",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10.sp, fontWeight: FontWeight.w700, color: const Color(0xff636363)),
              )
            ],
          ),
          GestureDetector(
            child: Text(
              "Forgot Password?",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10.sp, fontWeight: FontWeight.w700, color: const Color(0xff636363)),
            ),
            onTap: () {},
          )
        ],
      );
  signInBtn(BuildContext context) => BlocBuilder<LoginBLoc, LoginState>(
        builder: (context, state) {
          bool isValid = context.read<LoginBLoc>().isValidEmail && context.read<LoginBLoc>().isValidPass;
          if (state is LoginLoadingState) {
            return const CircularProgressIndicator();
          }

          return GestureDetector(
              onTap: () {
                isValid ? context.read<LoginBLoc>().add(LoginSubmitEvent(context, email: _emailController.text, password: _passController.text)) : null;
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 13.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: isValid ? whiteColor : mainColor),
                  borderRadius: BorderRadius.circular(30),
                  color: isValid ? mainColor : whiteColor,
                ),
                alignment: Alignment.center,
                child: Text(
                  "Sign in",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w700, color: isValid ? whiteColor : mainColor),
                ),
              ));
        },
      );
}
