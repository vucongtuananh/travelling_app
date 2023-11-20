import 'package:flutter/material.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/const/fonts.dart';
import 'package:travelling_app/models/location.dart';

class LocationContainer extends StatelessWidget {
  const LocationContainer({super.key, required this.location});

  final Location location;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.hardEdge,
          child: Image.asset(
            "$imagePathHdpi/${location.image}",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 20,
          left: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location.title,
                style: whiteTextW6Style.copyWith(fontSize: 20),
              ),
              Text(
                "${location.distance}km",
                style: whiteTextW6Style.copyWith(fontSize: 15),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget startLocation() {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), gradient: const LinearGradient(colors: linearMainColor, begin: Alignment.topLeft, end: Alignment.bottomRight)),
      padding: const EdgeInsets.only(top: 12, bottom: 12, right: 18, left: 8),
      child: Row(
        children: [
          Image.asset("$imagePathLdpi/send.png"),
          const SizedBox(
            width: 5,
          ),
          Text(
            "Start",
            style: whiteTextW4Style.copyWith(fontSize: 13),
          )
        ],
      ),
    );
  }
}
