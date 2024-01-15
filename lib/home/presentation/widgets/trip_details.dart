import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/const/fonts.dart';
import 'package:travelling_app/home/data/models/trip.dart';
import 'package:travelling_app/home/logic/favorite_trip_bloc/favorite_trip_bloc.dart';
import 'package:travelling_app/home/logic/favorite_trip_bloc/favorite_trip_event.dart';
import 'package:travelling_app/home/logic/favorite_trip_bloc/favorite_trip_state.dart';
import 'package:travelling_app/widgets/container_button.dart';

class TripDetails extends StatefulWidget {
  const TripDetails({super.key, required this.trip});

  final Trip trip;

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  @override
  void didChangeDependencies() {
    // context.read<FavoriteTripBloc>().add(TripFavoriteRestartEvent(trip: widget.trip));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lake View",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: const Color(0xff323232), fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          img(),
          SizedBox(
            height: 20.h,
          ),
          content(context)
        ]),
      ),
    );
  }

  Padding content(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          title(context),
          SizedBox(
            height: 16.h,
          ),
          location(context),
          SizedBox(
            height: 20.h,
          ),
          Text(
            widget.trip.describe,
            style: grayTextW4Style.copyWith(fontSize: 15.sp),
          ),
          SizedBox(
            height: 25.h,
          ),
          bookAndFavorite(context)
        ],
      ),
    );
  }

  Row bookAndFavorite(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ContainerButton(
          title: "Booking Now | \$${widget.trip.price}",
          colorContainer: mainColor,
          paddingHorizontal: 74.h,
          paddingVertical: 13.h,
          titleStyle: whiteTextW6Style,
          borderRadius: 20,
          margin: EdgeInsets.only(bottom: 100.h),
        ),
        SizedBox(
          width: 5.w,
        ),

        // var isFavorite = state.contains(trip);
        GestureDetector(onTap: () {
          context.read<FavoriteTripBloc>().state is FavoriteTripLoadingState
              ? null
              : context.read<FavoriteTripBloc>().add(widget.trip.isFavorite ? FavoriteTripRemove(trip: widget.trip) : FavoriteTripAdd(trip: widget.trip));
        }, child: BlocBuilder<FavoriteTripBloc, TripFavoriteState>(
          builder: (context, state) {
            if (state == FavoriteTripLoadingState()) {
              return SizedBox(width: 20.w, height: 20.h, child: const CircularProgressIndicator());
            }
            if (state == UnfavoriteTripState(trip: widget.trip) || !widget.trip.isFavorite) {
              return SvgPicture.asset(
                "$imagePathLdpi/heart_white.svg",
                width: 30.w,
                height: 30.h,
              );
            }
            if (state == FavoriteTripState(trip: widget.trip) || widget.trip.isFavorite) {
              return SvgPicture.asset(
                "$imagePathLdpi/heart_icon.svg",
                width: 30.w,
                height: 30.h,
              );
            }
            return const SizedBox();
          },
        ))
      ],
    );
  }

  Row location(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset("$imagePathLdpi/location_blur_icon.svg"),
        const SizedBox(
          width: 2,
        ),
        Text(
          widget.trip.location,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: grayColor, fontSize: 15.sp, fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  Row title(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.trip.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: const Color(0xff323232), fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            SvgPicture.asset("$imagePathLdpi/star_icon.svg"),
            Text(
              "${widget.trip.rate}",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: const Color(0xff636363), fontSize: 18.sp, fontWeight: FontWeight.w400),
            )
          ],
        )
      ],
    );
  }

  Hero img() {
    return Hero(
      tag: widget.trip.id,
      child: Container(
        width: 344.w,
        height: 370.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.network(
          widget.trip.imgPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
