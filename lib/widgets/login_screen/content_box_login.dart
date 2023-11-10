import 'package:flutter/material.dart';
import 'package:travelling_app/assets_image.dart';

class ContentBoxLogin extends StatelessWidget {
  const ContentBoxLogin({super.key});

  @override
  Widget build(BuildContext context) {
    Widget formLogin = Form(
        child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          width: double.infinity,
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: const BorderRadius.all(Radius.circular(30))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("$imagePathLdpi/email.png"),
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
              Image.asset("$imagePathLdpi/lock.png"),
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

    var size = MediaQuery.of(context).size;
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    GestureDetector(
                      child: Text(
                        "Forgot Password?",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10, fontWeight: FontWeight.w700),
                      ),
                      onTap: () {},
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Sign in",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15, fontWeight: FontWeight.w700, color: const Color(0xffffffff)),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
