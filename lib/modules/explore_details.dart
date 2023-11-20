import 'package:flutter/material.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/const/fonts.dart';
import 'package:travelling_app/const/size.dart';
import 'package:travelling_app/models/location.dart';

class ExploreDetails extends StatelessWidget {
  const ExploreDetails({super.key, required this.location});

  final Location location;

  @override
  Widget build(BuildContext context) {
    var _size = size(context);
    return Scaffold(
      body: Stack(children: [
        SizedBox(
            width: _size.width,
            height: _size.height,
            child: Image.asset(
              "$imagePathHdpi/${location.image}",
              fit: BoxFit.cover,
            )),
        Container(
          width: _size.width,
          height: _size.height / 2.4,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(children: [
            Image.asset("$imagePathHdpi/${location.imageDetail}"),
            Row(
              children: [
                Text(
                  location.titleDetail,
                  style: blackTextW6Style.copyWith(fontSize: 20),
                ),
                Row(
                  children: [],
                )
              ],
            ),
            Text(
              location.describe,
              style: grayTextW6Style.copyWith(fontSize: 11),
            ),
          ]),
        )
      ]),
    );
  }
}
