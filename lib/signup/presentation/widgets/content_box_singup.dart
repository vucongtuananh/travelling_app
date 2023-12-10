import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/signup/logic/sign_up_event.dart';
import 'package:travelling_app/signup/logic/signup_bloc.dart';
import 'package:travelling_app/signup/logic/signup_state.dart';

class ContentBoxSignUp extends StatefulWidget {
  const ContentBoxSignUp({super.key});

  @override
  State<ContentBoxSignUp> createState() => _ContentBoxSignUpState();
}

class _ContentBoxSignUpState extends State<ContentBoxSignUp> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _rePassController = TextEditingController();
  bool _isShowPass = false;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _rePassController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          signUpBtn(context),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }

  signUpBtn(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        // bool isValid = state is SignUpValidState || state is SignUpLoadedState;
        final bloc = BlocProvider.of<SignUpBloc>(context);
        bool isValid = bloc.isValidEmail && bloc.isValidName && bloc.isValidPass && bloc.isValidRePass;
        return GestureDetector(
          onTap: () {
            isValid
                ? BlocProvider.of<SignUpBloc>(context).add(SignUpPostEvent(context, email: _emailController.text, name: _nameController.text, pass: _passController.text))
                : null;
          },
          child: state is SignUpLoadingState
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  width: double.infinity,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30), border: Border.all(color: isValid ? whiteColor : mainColor), color: isValid ? mainColor : null),
                  alignment: Alignment.center,
                  child: Text(
                    "Create Account",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15, fontWeight: FontWeight.w700, color: isValid ? whiteColor : mainColor),
                  ),
                ),
        );
      },
    );
  }

  formSignUp(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          nameInput(context),
          const SizedBox(
            height: 5,
          ),
          BlocBuilder<SignUpBloc, SignUpState>(
            builder: (context, state) {
              if (state is SignUpErrorNameState) {
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
          emailInput(context),
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
          passInput(context),
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
          ),
          const SizedBox(
            height: 15,
          ),
          rePassInput(context),
          const SizedBox(
            height: 5,
          ),
          BlocBuilder<SignUpBloc, SignUpState>(
            builder: (context, state) {
              if (state is SignUpErrorRePassState) {
                return Text(
                  state.errorRePass,
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

  TextFormField rePassInput(BuildContext context) {
    return TextFormField(
      scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      controller: _rePassController,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: mainColor,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
      onChanged: (value) {
        context.read<SignUpBloc>().add(SignUpTextRePassChangeEvent(pass: _passController.text, rePass: _rePassController.text));
      },
      obscureText: _isShowPass ? false : true,
      decoration: InputDecoration(
          suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _isShowPass = !_isShowPass;
                });
              },
              child: _isShowPass ? const Icon(Icons.visibility_off_rounded) : const Icon(Icons.visibility_rounded)),
          label: Text(
            "Password",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: grayColor, fontSize: 12, fontWeight: FontWeight.w700),
          )),
    );
  }

  TextFormField passInput(BuildContext context) {
    return TextFormField(
      controller: _passController,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: mainColor,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
      onChanged: (value) {
        context.read<SignUpBloc>().add(SignUpTextPassChangeEvent(pass: _passController.text));
      },
      obscureText: _isShowPass ? false : true,
      decoration: InputDecoration(
          suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _isShowPass = !_isShowPass;
                });
              },
              child: _isShowPass ? const Icon(Icons.visibility_off_rounded) : const Icon(Icons.visibility_rounded)),
          label: Text(
            "Password",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: grayColor, fontSize: 12, fontWeight: FontWeight.w700),
          )),
    );
  }

  TextFormField emailInput(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      onChanged: (value) {
        context.read<SignUpBloc>().add(SignUpTextEmailChangeEvent(
              email: _emailController.text,
            ));
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
              if (context.read<SignUpBloc>().isValidEmail) {
                return Image.asset(
                  "$imagePathLdpi/check.png",
                  color: mainColor,
                );
              }
              return const SizedBox();
            },
          )),
    );
  }

  TextFormField nameInput(BuildContext context) {
    return TextFormField(
      controller: _nameController,
      onChanged: (value) {
        context.read<SignUpBloc>().add(SignUpTextNameChangeEvent(name: _nameController.text));
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
              if (context.read<SignUpBloc>().isValidName) {
                return Image.asset(
                  "$imagePathLdpi/check.png",
                  color: mainColor,
                );
              }
              return const SizedBox();
            },
          )),
    );
  }
}
