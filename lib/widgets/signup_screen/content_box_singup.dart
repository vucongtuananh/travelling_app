import 'package:flutter/material.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';

class ContentBoxSignUp extends StatefulWidget {
  const ContentBoxSignUp({super.key});

  @override
  State<ContentBoxSignUp> createState() => _ContentBoxSignUpState();
}

class _ContentBoxSignUpState extends State<ContentBoxSignUp> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var formSignUp = Form(
      child: Column(
        children: [
          Stack(children: [
            TextFormField(
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: blackColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
              decoration: InputDecoration(
                  suffixIcon: Image.asset(
                "$imagePathLdpi/check.png",
                color: mainColor,
              )),
            ),
            Positioned(
              child: Text(
                "Username",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: grayColor, fontSize: 12, fontWeight: FontWeight.w700),
              ),
            )
          ]),
          const SizedBox(height: 20),
          Stack(children: [
            TextFormField(
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: blackColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
              decoration: InputDecoration(
                  suffixIcon: Image.asset(
                "$imagePathLdpi/check.png",
                color: mainColor,
              )),
            ),
            Positioned(
              child: Text(
                "Username",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: grayColor, fontSize: 12, fontWeight: FontWeight.w700),
              ),
            )
          ]),
          const SizedBox(
            height: 20,
          ),
          Stack(children: [
            TextFormField(
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: mainColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
              obscureText: true,
            ),
            Positioned(
              child: Text(
                "Password",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: grayColor, fontSize: 12, fontWeight: FontWeight.w700),
              ),
            )
          ]),
        ],
      ),
    );
    Widget handleInput = Row(
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
              style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xff636363)),
            )
          ],
        ),
        GestureDetector(
          child: Text(
            "Forgot Password?",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xff636363)),
          ),
          onTap: () {},
        )
      ],
    );
    Widget signInBtn = Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: mainColor,
      ),
      alignment: Alignment.center,
      child: Text(
        "Sign in",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15, fontWeight: FontWeight.w700, color: whiteColor),
      ),
    );
    Widget signUpBtn = Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), border: Border.all(color: mainColor)),
      alignment: Alignment.center,
      child: Text(
        "Create Account",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15, fontWeight: FontWeight.w700, color: mainColor),
      ),
    );
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
        formSignUp,
        const SizedBox(
          height: 20,
        ),
        handleInput,
        const SizedBox(
          height: 30,
        ),
        signInBtn,
        const SizedBox(
          height: 30,
        ),
        Center(
          child: Text(
            "Don’t have an Account?",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: grayColor, fontSize: 10, fontWeight: FontWeight.w400),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        signUpBtn
      ],
    );
  }
}
