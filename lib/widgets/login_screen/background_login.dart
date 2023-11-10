import 'package:flutter/material.dart';
import 'package:travelling_app/assets_image.dart';

class BackgroundLogin extends StatelessWidget {
  const BackgroundLogin({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var heigh = size.height;
    var width = size.width;
    return Stack(children: [
      Container(
        color: Theme.of(context).colorScheme.primary.withOpacity(1),
      ),
      Positioned(
        left: width * 0.5,
        bottom: heigh * 0.75,
        child: Opacity(
          opacity: 0.2,
          child: Image.asset(
            "$imagePathLdpi/icon_earth.png",
            scale: 0.5,
            fit: BoxFit.none,
          ),
        ),
      ),
      Positioned(
        // right: ,
        right: 0,
        top: heigh * 0.6,
        child: Opacity(
          opacity: 0.2,
          child: Image.asset(
            "$imagePathLdpi/icon_earth.png",
            scale: 0.4,
            fit: BoxFit.none,
          ),
        ),
      ),
    ]);
  }
}
