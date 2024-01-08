import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/const/fonts.dart';
import 'package:travelling_app/const/size.dart';
import 'package:travelling_app/home/data/models/location.dart';

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
        padding: EdgeInsets.only(top: 8.h, left: 10.w, right: 10.w),
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
                style: blackTextW6Style.copyWith(fontSize: 20.sp),
              ),
              Row(
                children: [
                  SvgPicture.asset("$imagePathLdpi/star_icon.svg"),
                  Text(
                    location.rate.toString(),
                    style: grayTextW4Style.copyWith(fontSize: 13.sp),
                  )
                ],
              )
            ],
          ),
          Text(
            location.describe,
            style: grayTextW6Style.copyWith(fontSize: 11.sp),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(width: 25.w, height: 25.h, child: Image.asset("$imagePathMdpi/${location.tourGuide.image}")),
              SizedBox(
                width: 5.w,
              ),
              Text(
                location.tourGuide.name,
                style: blackTextW6Style.copyWith(color: mainColor, fontSize: 11.sp),
              ),
              SizedBox(
                width: 20.w,
              ),
              Text(
                location.tourGuide.status,
                style: grayTextW4Style.copyWith(fontSize: 10.sp),
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
