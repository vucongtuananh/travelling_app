import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    var size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header(context),
        const SizedBox(
          height: 17,
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: size.width,
            height: size.height * 0.75,
            decoration: const BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1), borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                const SizedBox(
                  height: 49,
                ),
                Image.asset("$imagePathLdpi/icon_earth.png"),
                const SizedBox(
                  height: 30,
                ),
                formLogin(context),
                const SizedBox(
                  height: 20,
                ),
                handleInput(context),
                const SizedBox(
                  height: 30,
                ),
                signInBtn(context),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        signInByOtherWay(),
        const SizedBox(
          height: 24,
        ),
        signUp(context)
      ],
    );
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

  Text header(BuildContext context) =>
      Text("Welcome Back!", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700, fontSize: 25, color: Theme.of(context).colorScheme.onPrimary));

  formLogin(BuildContext context) => Form(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            width: double.infinity,
            decoration: const BoxDecoration(color: mainColor, borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "$imagePathLdpi/email_icon.svg",
                  color: const Color(0xffE9E9E9),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    controller: _emailController,
                    onChanged: (value) {
                      context.read<LoginBLoc>().add(LoginTextChangeEmailEvent(email: _emailController.text));
                    },
                    cursorColor: const Color(0xffFFFFFF),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                    decoration: InputDecoration(
                      // contentPadding: const EdgeInsets.only(bottom: 4),
                      fillColor: Theme.of(context).colorScheme.onPrimaryContainer,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                BlocBuilder<LoginBLoc, LoginState>(
                  builder: (context, state) {
                    if (context.read<LoginBLoc>().isValidEmail) {
                      return SvgPicture.asset("$imagePathLdpi/check.svg");
                    } else {
                      return const SizedBox();
                    }
                  },
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          BlocBuilder<LoginBLoc, LoginState>(
            builder: (context, state) {
              if (state is LoginErrorEmailState) {
                return Text(
                  state.errorEmail,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.red,
                      ),
                );
              }
              return const SizedBox();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            width: double.infinity,
            decoration: BoxDecoration(border: Border.all(color: const Color(0xff008FA0)), borderRadius: BorderRadius.circular(30)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "$imagePathLdpi/lock_icon.svg",
                  color: grayColor,
                ),
                const SizedBox(
                  width: 10,
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
                          fontSize: 15,
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
          const SizedBox(
            height: 5,
          ),
          BlocBuilder<LoginBLoc, LoginState>(
            builder: (context, state) {
              if (state is LoginErrorPassState) {
                return Text(
                  state.errorPass,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.red,
                      ),
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
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: whiteColor, borderRadius: BorderRadius.circular(45)),
              child: Image.asset("$imagePathLdpi/google.png")),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: whiteColor, borderRadius: BorderRadius.circular(45)),
              child: Image.asset("$imagePathLdpi/facebook.png")),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(4),
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
                  width: 11,
                  height: 11,
                  decoration: BoxDecoration(border: Border.all(color: Theme.of(context).colorScheme.primary)),
                  child: Icon(
                    Icons.check,
                    color: Theme.of(context).colorScheme.onBackground,
                    size: 12,
                  ),
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                "Remember me",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10, fontWeight: FontWeight.w700, color: const Color(0xff636363)),
              )
            ],
          ),
          GestureDetector(
            child: Text(
              "Forgot Password?",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10, fontWeight: FontWeight.w700, color: const Color(0xff636363)),
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
                padding: const EdgeInsets.symmetric(vertical: 13),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: isValid ? whiteColor : mainColor),
                  borderRadius: BorderRadius.circular(30),
                  color: isValid ? mainColor : whiteColor,
                ),
                alignment: Alignment.center,
                child: Text(
                  "Sign in",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15, fontWeight: FontWeight.w700, color: isValid ? whiteColor : mainColor),
                ),
              ));
        },
      );
}
