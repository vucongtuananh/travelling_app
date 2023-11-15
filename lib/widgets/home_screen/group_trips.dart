import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/models/home_models/group_trip.dart';

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
                "${groupTrip.title}",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: blackColor, fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Text(
                "${groupTrip.name}",
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
                    "${groupTrip.location}",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: grayBlurColor, fontSize: 11, fontWeight: FontWeight.w400),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
                width: 150,
                height: 6,
                child: LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(20),
                  valueColor: const AlwaysStoppedAnimation<Color>(mainColor),
                  value: groupTrip.percent / 100,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
