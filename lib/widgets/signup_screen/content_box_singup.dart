import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/modules/signup_screen/sign_up_event.dart';
import 'package:travelling_app/modules/signup_screen/signup_cubit.dart';
import 'package:travelling_app/modules/signup_screen/signup_state.dart';

class ContentBoxSignUp extends StatefulWidget {
  const ContentBoxSignUp({super.key});

  @override
  State<ContentBoxSignUp> createState() => _ContentBoxSignUpState();
}

class _ContentBoxSignUpState extends State<ContentBoxSignUp> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: size.width * 0.5,
          child: Text(
            "Let’s start your Journey together!",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: blackColor, fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(child: SizedBox(child: Image.asset("$imagePathLdpi/icon_earth.png"))),
        const SizedBox(
          height: 30,
        ),
        formSignUp(context),
        // const SizedBox(
        //   height: 20,
        // ),
        // signInBtn(context),
        const SizedBox(
          height: 30,
        ),
        const SizedBox(
          height: 30,
        ),
        signUpBtn(context)
      ],
    );
  }

  signUpBtn(BuildContext context) {
    bool isValid = context.read<SignUpBloc>().isValid();
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {},
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), border: Border.all(color: mainColor), color: isValid ? null : mainColor),
                  alignment: Alignment.center,
                  child: Text(
                    "Create Account",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15, fontWeight: FontWeight.w700, color: isValid ? mainColor : whiteColor),
                  ),
                ),
        );
      },
    );
  }

  formSignUp(BuildContext context) {
    var _bloc = context.read<SignUpBloc>();
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            onChanged: (value) {
              context.read<SignUpBloc>().add(SignUpNameTextChangeEvent(userName: _nameController.text));
            },
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: blackColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
            decoration: InputDecoration(
                label: Text(
                  "Username",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: grayColor, fontSize: 12, fontWeight: FontWeight.w700),
                ),
                suffixIcon: BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    if (state is SingUpValidNameState) {
                      return Image.asset(
                        "$imagePathLdpi/check.png",
                        color: mainColor,
                      );
                    }
                    return const SizedBox();
                  },
                )),
          ),
          const SizedBox(
            height: 5,
          ),
          BlocBuilder<SignUpBloc, SignUpState>(
            builder: (context, state) {
              if (state is SignUpErrorUserNameState) {
                return Text(
                  state.errorName,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.red,
                      ),
                );
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _emailController,
            onChanged: (value) {
              context.read<SignUpBloc>().add(SignUpEmailTextChangeEvent(email: _emailController.text));
            },
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: blackColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
            decoration: InputDecoration(
                label: Text(
                  "Email",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: grayColor, fontSize: 12, fontWeight: FontWeight.w700),
                ),
                suffixIcon: BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    if (state is SingUpValidEmailState) {
                      return Image.asset(
                        "$imagePathLdpi/check.png",
                        color: mainColor,
                      );
                    }
                    return const SizedBox();
                  },
                )),
          ),
          const SizedBox(
            height: 5,
          ),
          BlocBuilder<SignUpBloc, SignUpState>(
            builder: (context, state) {
              if (state is SignUpErrorEmailState) {
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
            height: 15,
          ),
          TextFormField(
            controller: _passController,
            onChanged: (value) {
              context.read<SignUpBloc>().add(SignUpPassTextChangeEvent(pass: _passController.text));
            },
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: mainColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
            obscureText: true,
            decoration: InputDecoration(
                label: Text(
              "Password",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: grayColor, fontSize: 12, fontWeight: FontWeight.w700),
            )),
          ),
          const SizedBox(
            height: 5,
          ),
          BlocBuilder<SignUpBloc, SignUpState>(
            builder: (context, state) {
              if (state is SignUpErrorPassState) {
                return Text(
                  state.errorPass,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.red,
                      ),
                );
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
