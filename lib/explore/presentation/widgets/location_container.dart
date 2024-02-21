import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/const/fonts.dart';
import 'package:travelling_app/home/data/models/location.dart';

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
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
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
          top: 20.h,
          left: 30.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location.title,
                style: whiteTextW6Style.copyWith(fontSize: 20.sp),
              ),
              Text(
                "${location.distance}km",
                style: whiteTextW6Style.copyWith(fontSize: 15.sp),
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
      padding: EdgeInsets.only(top: 12.h, bottom: 12.h, right: 18.w, left: 8.w),
      child: Row(
        children: [
          SizedBox(width: 16.w, height: 16.h, child: Image.asset("$imagePathLdpi/send.png")),
          SizedBox(
            width: 5.w,
          ),
          Text(
            "Start",
            style: whiteTextW4Style.copyWith(fontSize: 13.sp),
          )
        ],
      ),
    );
  }
}
