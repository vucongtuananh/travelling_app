import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      body: Stack(children: [_backGround(_size, context), _detailCard(_size), _backArrow(context)]),
    );
  }

  Positioned _detailCard(Size size) {
    return Positioned(
      bottom: 20,
      left: 21,
      right: 21,
      child: Container(
        padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
        // width: size.width,
        height: size.height / 2.4,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.asset("$imagePathHdpi/${location.imageDetail}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                location.titleDetail,
                style: blackTextW6Style.copyWith(fontSize: 20),
              ),
              Row(
                children: [
                  SvgPicture.asset("$imagePathLdpi/star_icon.svg"),
                  Text(
                    location.rate.toString(),
                    style: grayTextW4Style.copyWith(fontSize: 13),
                  )
                ],
              )
            ],
          ),
          Text(
            location.describe,
            style: grayTextW6Style.copyWith(fontSize: 11),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Image.asset("$imagePathMdpi/${location.tourGuide.image}"),
              const SizedBox(
                width: 5,
              ),
              Text(
                location.tourGuide.name,
                style: blackTextW6Style.copyWith(color: mainColor, fontSize: 11),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                location.tourGuide.status,
                style: grayTextW4Style.copyWith(fontSize: 10),
              )
            ],
          )
        ]),
      ),
    );
  }

  SizedBox _backGround(Size size, BuildContext context) {
    return SizedBox(
        width: size.width,
        height: size.height + MediaQuery.of(context).padding.top,
        child: Image.asset(
          "$imagePathHdpi/${location.image}",
          fit: BoxFit.cover,
        ));
  }

  _backArrow(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top,
      left: 23,
      child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset("$imagePathLdpi/back_arrow.svg")),
    );
  }
}
