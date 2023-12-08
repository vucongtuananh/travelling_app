import 'package:flutter/material.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';

class BackgroundSingUp extends StatelessWidget {
  const BackgroundSingUp({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var heigh = size.height;
    var width = size.width;
    return Stack(children: [
      Container(
        color: whiteColor,
      ),
      Positioned(
        left: width * 0.5,
        bottom: heigh * 0.75,
        child: Image.asset(
          "$imagePathLdpi/icon_earth.png",
          scale: 0.5,
          fit: BoxFit.none,
          color: mainColor.withOpacity(0.2),
        ),
      ),
      Positioned(
        // right: ,
        right: 0,
        top: heigh * 0.6,
        child: Image.asset(
          "$imagePathLdpi/icon_earth.png",
          scale: 0.4,
          fit: BoxFit.none,
          color: mainColor.withOpacity(0.2),
        ),
      ),
    ]);
  }
}
