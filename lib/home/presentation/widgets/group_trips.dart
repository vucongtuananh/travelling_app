import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/const/fonts.dart';
import 'package:travelling_app/home/data/models/group_trip.dart';
import 'package:travelling_app/signup/data/models/user.dart';

class GroupTripCard extends StatelessWidget {
  const GroupTripCard({super.key, required this.groupTrip});

  final GroupTrip groupTrip;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 4.h, left: 4.w, bottom: 3.w),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              width: 141.w,
              height: 126.h,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                "$imagePathHdpi/group_trip_1.png",
                fit: BoxFit.cover,
              )),
          SizedBox(
            width: 19.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                groupTrip.title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: blackColor, fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                groupTrip.name,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: grayColor, fontSize: 12.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  SvgPicture.asset("$imagePathLdpi/location_blur_icon.svg"),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    groupTrip.location,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: grayBlurColor, fontSize: 11.sp, fontWeight: FontWeight.w400),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              // Row(
              //   children: [
              //     listUser(listUsers, context),
              //     const SizedBox(
              //       width: 5,
              //     ),
              //     Text(
              //       "110+ Orders",
              //       style: blackTextW4Style.copyWith(
              //         fontSize: 4,
              //       ),
              //     )
              //   ],
              // ),
              SizedBox(
                height: 10.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${groupTrip.percent.toInt()} %",
                        style: blackTextW7Style.copyWith(color: mainColor, fontSize: 9.sp),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    width: 150.w,
                    height: 6.h,
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(20),
                      valueColor: const AlwaysStoppedAnimation<Color>(mainColor),
                      semanticsLabel: groupTrip.percent.toString(),
                      semanticsValue: groupTrip.percent.toString(),
                      value: groupTrip.percent / 100,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget listUser(List<UserModel> users, BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width / 7,
        height: 15,
        child: Stack(
          //     children:
          //      users.map((e) {
          //   return Positioned(
          //       left: e.id,
          //       child: Image.asset(
          //         e.imgPath,
          //         scale: 3,
          //       ));
          // }).toList()),
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 5.5,
              height: 15,
            ),
            // for (var e in users)
            //   Positioned(
            //       left: e.id * 10,
            //       child: Image.asset(
            //         e.imgPath,
            //         scale: 3,
            //       ))
          ],
        ));
  }
}
