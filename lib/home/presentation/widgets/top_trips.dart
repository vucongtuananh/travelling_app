import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/home/logic/favorite_trip_bloc/favorite_trip_bloc.dart';
import 'package:travelling_app/home/logic/favorite_trip_bloc/favorite_trip_event.dart';
import 'package:travelling_app/home/logic/favorite_trip_bloc/favorite_trip_state.dart';
import 'package:travelling_app/home/presentation/widgets/trip_details.dart';
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
    context.read<FavoriteTripBloc>().add(TripFavoriteRestartEvent(trip: widget.trip));
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 150.w,
        height: 212.h,
        padding: EdgeInsets.only(top: 2.h, left: 2.w, right: 2.w, bottom: 9.h),
        margin: const EdgeInsets.only(right: 13),
        decoration: BoxDecoration(color: whiteColor, borderRadius: BorderRadius.circular(20), boxShadow: const [
          BoxShadow(
            color: grayBlurColor,
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(1, 1),
          )
        ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: widget.trip.id,
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                height: 110.h,
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  widget.trip.imgPath,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                children: [
                  firstLine(context),
                  SizedBox(
                    height: 12.h,
                  ),
                  secondLine(context),
                  SizedBox(
                    height: 18.h,
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
                value: BlocProvider.of<FavoriteTripBloc>(context),
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
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xff008FA0), fontSize: 12.sp, fontWeight: FontWeight.w400),
              children: [TextSpan(text: " /Visit", style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: blackColor, fontSize: 12.sp, fontWeight: FontWeight.w400))]),
        ),
        BlocBuilder<FavoriteTripBloc, TripFavoriteState>(
          builder: (context, state) {
            if (state == FavoriteTripLoadedState(isFavorite: false, id: widget.trip.id) || state == FavoriteTripCheckState(isFavorite: false, id: widget.trip.id)) {
              return SvgPicture.asset(
                "$imagePathLdpi/heart_white.svg",
                width: 10.w,
                height: 10.h,
              );
            }
            if (state == FavoriteTripLoadedState(isFavorite: true, id: widget.trip.id) || state == FavoriteTripCheckState(isFavorite: true, id: widget.trip.id)) {
              return SvgPicture.asset(
                "$imagePathLdpi/heart_icon.svg",
                width: 10.w,
                height: 10.h,
              );
            }
            return SvgPicture.asset(
              "$imagePathLdpi/heart_white.svg",
              width: 10.w,
              height: 10.h,
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
        SizedBox(width: 4.w),
        Text(
          widget.trip.location,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: const Color(0xff636363), fontSize: 11.sp, fontWeight: FontWeight.w400),
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
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: const Color(0xff1E1E1E), fontSize: 13.sp, fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            SvgPicture.asset("$imagePathLdpi/star_icon.svg"),
            Text(
              "${widget.trip.rate}",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: const Color(0xff636363), fontSize: 10.sp, fontWeight: FontWeight.w400),
            )
          ],
        )
      ],
    );
  }
}
