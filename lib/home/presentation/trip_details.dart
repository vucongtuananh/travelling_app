import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelling_app/bloc/favorite_bloc.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/const/fonts.dart';
import 'package:travelling_app/home/data/models/trip.dart';
import 'package:travelling_app/widgets/container_button.dart';

class TripDetails extends StatelessWidget {
  const TripDetails({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
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
          content(context)
        ]),
      ),
    );
  }

  Padding content(BuildContext context) {
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
            trip.describe,
            style: grayTextW4Style.copyWith(fontSize: 15),
          ),
          const SizedBox(
            height: 25,
          ),
          bookAndFavorite(context)
        ],
      ),
    );
  }

  Row bookAndFavorite(BuildContext context) {
    return Row(
      children: [
        ContainerButton(
          title: "Booking Now | \$${trip.price}",
          colorContainer: mainColor,
          paddingHorizontal: 74,
          paddingVertical: 13,
          titleStyle: whiteTextW6Style,
          borderRadius: 20,
          margin: const EdgeInsets.only(bottom: 100),
        ),
        const SizedBox(
          width: 5,
        ),

        // var isFavorite = state.contains(trip);
        BlocBuilder<IsFavorite, List<Trip>>(
          builder: (context, state) {
            var isFavorite = state.contains(trip);
            return GestureDetector(
                onTap: () {
                  BlocProvider.of<IsFavorite>(context).toggleFavorite(trip);
                },
                child: isFavorite
                    ? SvgPicture.asset(
                        "$imagePathLdpi/heart_icon.svg",
                        width: 30,
                        height: 30,
                      )
                    : SvgPicture.asset(
                        "$imagePathLdpi/heart_white.svg",
                        width: 30,
                        height: 30,
                      ));
          },
        )
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
          trip.location,
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
          trip.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: const Color(0xff323232), fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            SvgPicture.asset("$imagePathLdpi/star_icon.svg"),
            Text(
              "${trip.rate}",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: const Color(0xff636363), fontSize: 18, fontWeight: FontWeight.w400),
            )
          ],
        )
      ],
    );
  }

  Hero img(double h) {
    return Hero(
      tag: trip.id,
      child: SizedBox(
        width: double.infinity,
        height: h / 2,
        child: Image.network(
          trip.imgPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}