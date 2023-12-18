import 'package:flutter/material.dart';
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
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Image.asset("$imagePathHdpi/group_trip_1.png"),
          const SizedBox(
            width: 19,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                groupTrip.title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: blackColor, fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Text(
                groupTrip.name,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: grayColor, fontSize: 12, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SvgPicture.asset("$imagePathLdpi/location_blur_icon.svg"),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    groupTrip.location,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: grayBlurColor, fontSize: 11, fontWeight: FontWeight.w400),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
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
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${groupTrip.percent.toInt()} %",
                        style: blackTextW7Style.copyWith(color: mainColor, fontSize: 9),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    width: 150,
                    height: 6,
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

  Widget listUser(List<User> users, BuildContext context) {
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
