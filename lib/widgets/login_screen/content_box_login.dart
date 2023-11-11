import 'package:flutter/material.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';

class ContentBoxLogin extends StatefulWidget {
  const ContentBoxLogin({super.key});

  @override
  State<ContentBoxLogin> createState() => _ContentBoxLoginState();
}

class _ContentBoxLoginState extends State<ContentBoxLogin> {
  @override
  Widget build(BuildContext context) {
    Widget formLogin = Form(
        child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          width: double.infinity,
          decoration: const BoxDecoration(color: mainColor, borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "$imagePathLdpi/email.png",
                color: const Color(0xffE9E9E9),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  cursorColor: const Color(0xffFFFFFF),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                  decoration: InputDecoration(
                    // contentPadding: const EdgeInsets.only(bottom: 4),
                    fillColor: Theme.of(context).colorScheme.onPrimaryContainer,
                    border: InputBorder.none,
                  ),
                ),
              ),
              Image.asset("$imagePathLdpi/check.png")
            ],
          ),
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
              Image.asset(
                "$imagePathLdpi/lock.png",
                color: grayColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  obscureText: true,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onBackground),
                  decoration: InputDecoration(
                    // contentPadding: const EdgeInsets.only(bottom: 4),
                    fillColor: Theme.of(context).colorScheme.onPrimaryContainer,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));

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
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15, fontWeight: FontWeight.w700, color: const Color(0xffffffff)),
      ),
    );

    var size = MediaQuery.of(context).size;
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
    Widget signInByOtherWay = Row(
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Welcome Back!", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700, fontSize: 25, color: Theme.of(context).colorScheme.onPrimary)),
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
                formLogin,
                const SizedBox(
                  height: 20,
                ),
                handleInput,
                const SizedBox(
                  height: 30,
                ),
                signInBtn,
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        signInByOtherWay,
        const SizedBox(
          height: 24,
        ),
        Row(
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
              onTap: () {},
              child: Text(
                " Sign up here",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: whiteColor, fontWeight: FontWeight.w700, fontSize: 12, decoration: TextDecoration.underline),
              ),
            ),
          ],
        )
      ],
    );
  }
}
