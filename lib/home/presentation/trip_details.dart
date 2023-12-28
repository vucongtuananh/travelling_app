import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/const/fonts.dart';
import 'package:travelling_app/home/data/models/trip.dart';
import 'package:travelling_app/home/logic/home_bloc/home_bloc.dart';
import 'package:travelling_app/home/logic/home_bloc/home_event.dart';
import 'package:travelling_app/home/logic/home_bloc/home_state.dart';
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
    context.read<HomeBloc>().add(HomeReStartEvent(trip: widget.trip));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var h = size.height;
    var w = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lake View",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: const Color(0xff323232), fontSize: 16, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          img(h),
          const SizedBox(
            height: 20,
          ),
          content(context, size)
        ]),
      ),
    );
  }

  Padding content(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          title(context),
          const SizedBox(
            height: 16,
          ),
          location(context),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.trip.describe,
            style: grayTextW4Style.copyWith(fontSize: 15),
          ),
          const SizedBox(
            height: 25,
          ),
          bookAndFavorite(context, size)
        ],
      ),
    );
  }

  Row bookAndFavorite(BuildContext context, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ContainerButton(
          title: "Booking Now | \$${widget.trip.price}",
          colorContainer: mainColor,
          paddingHorizontal: size.width * 0.18,
          paddingVertical: 13,
          titleStyle: whiteTextW6Style,
          borderRadius: 20,
          margin: const EdgeInsets.only(bottom: 100),
        ),
        const SizedBox(
          width: 5,
        ),

        // var isFavorite = state.contains(trip);
        GestureDetector(onTap: () {
          context.read<HomeBloc>().state is HomeLoadingState ? null : context.read<HomeBloc>().add(HomeMakeFavoriteTripEvent(trip: widget.trip));
        }, child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state == HomeLoadingState()) {
              return const CircularProgressIndicator();
            }
            if (state == HomeFavoriteTripState(isFavorite: false, id: widget.trip.id) || state == HomeStartFavoriteTripState(isFavorite: false, id: widget.trip.id)) {
              return SvgPicture.asset(
                "$imagePathLdpi/heart_white.svg",
                width: 30,
                height: 30,
              );
            }
            if (state == HomeFavoriteTripState(isFavorite: true, id: widget.trip.id) || state == HomeStartFavoriteTripState(isFavorite: true, id: widget.trip.id)) {
              return SvgPicture.asset(
                "$imagePathLdpi/heart_icon.svg",
                width: 30,
                height: 30,
              );
            }
            return SvgPicture.asset(
              "$imagePathLdpi/heart_white.svg",
              width: 30,
              height: 30,
            );
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
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: grayColor, fontSize: 15, fontWeight: FontWeight.w400),
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
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: const Color(0xff323232), fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            SvgPicture.asset("$imagePathLdpi/star_icon.svg"),
            Text(
              "${widget.trip.rate}",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: const Color(0xff636363), fontSize: 18, fontWeight: FontWeight.w400),
            )
          ],
        )
      ],
    );
  }

  Hero img(double h) {
    return Hero(
      tag: widget.trip.id,
      child: SizedBox(
        width: double.infinity,
        height: h / 2,
        child: Image.network(
          widget.trip.imgPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
