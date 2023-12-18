import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/home/data/fire_store/fire_store.dart';
import 'package:travelling_app/home/logic/home_bloc.dart';
import 'package:travelling_app/home/logic/home_event.dart';
import 'package:travelling_app/home/logic/home_state.dart';
import 'package:travelling_app/home/presentation/trip_details.dart';
import '../../data/models/trip.dart';

class TopTrip extends StatefulWidget {
  const TopTrip({super.key, required this.trip});

  final Trip trip;

  @override
  State<TopTrip> createState() => _TopTripState();
}

class _TopTripState extends State<TopTrip> {
  @override
  void didChangeDependencies() {
    context.read<HomeBloc>().add(HomeReStartEvent(trip: widget.trip));
    super.didChangeDependencies();
  }

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
              tag: widget.trip.id,
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: 150,
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  widget.trip.imgPath,
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
                value: BlocProvider.of<HomeBloc>(context),
                child: TripDetails(trip: widget.trip),
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
              text: "\$${widget.trip.price}",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xff008FA0), fontSize: 12, fontWeight: FontWeight.w400),
              children: [TextSpan(text: " /Visit", style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: blackColor, fontSize: 12, fontWeight: FontWeight.w400))]),
        ),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state == HomeFavoriteTripState(isFavorite: false) || state == HomeStartFavoriteTripState(isFavorite: false)) {
              return SvgPicture.asset(
                "$imagePathLdpi/heart_white.svg",
                width: 10,
                height: 10,
              );
            }
            if (state == HomeFavoriteTripState(isFavorite: true) || state == HomeStartFavoriteTripState(isFavorite: true)) {
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
          widget.trip.location,
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
          widget.trip.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: const Color(0xff1E1E1E), fontSize: 13, fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            SvgPicture.asset("$imagePathLdpi/star_icon.svg"),
            Text(
              "${widget.trip.rate}",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: const Color(0xff636363), fontSize: 10, fontWeight: FontWeight.w400),
            )
          ],
        )
      ],
    );
  }
}
