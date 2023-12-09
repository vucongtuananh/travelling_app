import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelling_app/bloc/favorite_bloc.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/home/data/fire_store/fire_store.dart';
import 'package:travelling_app/home/presentation/trip_details.dart';
import '../../data/models/trip.dart';

class TopTrip extends StatelessWidget {
  const TopTrip({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    final FireStoreData _fireStoreData = FireStoreData(currentUserId: FirebaseAuth.instance.currentUser!.uid);
    return GestureDetector(
      child: Container(
        width: w / 2.5,
        padding: const EdgeInsets.only(top: 2, left: 2, right: 2, bottom: 9),
        margin: const EdgeInsets.only(right: 13),
        decoration: BoxDecoration(color: whiteColor, borderRadius: BorderRadius.circular(20), boxShadow: const [
          BoxShadow(
            color: grayBlurColor,
            blurRadius: 1,
            spreadRadius: 1,
          )
        ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: trip.id,
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: 150,
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  trip.imgPath,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  firstLine(context),
                  const SizedBox(
                    height: 12,
                  ),
                  secondLine(context),
                  const SizedBox(
                    height: 18,
                  ),
                  thirdLine(context)
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: BlocProvider.of<IsFavorite>(context),
                // create: (context) => IsFavorite(),
                child: TripDetails(trip: trip),
              ),
            ));
      },
    );
  }

  Widget thirdLine(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
              text: "\$${trip.price}",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xff008FA0), fontSize: 12, fontWeight: FontWeight.w400),
              children: [TextSpan(text: " /Visit", style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: blackColor, fontSize: 12, fontWeight: FontWeight.w400))]),
        ),
        BlocBuilder<IsFavorite, List<Trip>>(
          builder: (context, state) {
            var isFavorite = context.read<IsFavorite>().state.contains(trip);
            if (isFavorite) {
              return SvgPicture.asset(
                "$imagePathLdpi/heart_icon.svg",
                width: 10,
                height: 10,
              );
            }
            return SvgPicture.asset(
              "$imagePathLdpi/heart_white.svg",
              width: 10,
              height: 10,
            );
          },
        )
      ],
    );
  }

  Row secondLine(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset("$imagePathLdpi/location_blur_icon.svg"),
        const SizedBox(width: 4),
        Text(
          trip.location,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: const Color(0xff636363), fontSize: 11, fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  Row firstLine(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          trip.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: const Color(0xff1E1E1E), fontSize: 13, fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            SvgPicture.asset("$imagePathLdpi/star_icon.svg"),
            Text(
              "${trip.rate}",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: const Color(0xff636363), fontSize: 10, fontWeight: FontWeight.w400),
            )
          ],
        )
      ],
    );
  }
}