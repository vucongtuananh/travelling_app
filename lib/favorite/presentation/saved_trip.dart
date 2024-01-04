import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/const/fonts.dart';
import 'package:travelling_app/home/data/models/trip.dart';
import 'package:travelling_app/home/logic/favorite_trip_bloc/favorite_trip_bloc.dart';
import 'package:travelling_app/home/presentation/widgets/trip_details.dart';
import 'package:travelling_app/widgets/container_button.dart';

class SavedTrip extends StatelessWidget {
  const SavedTrip({super.key, required this.trip});

  final Trip trip;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: BlocProvider.of<FavoriteTripBloc>(context),
                child: TripDetails(trip: trip),
              ),
            ));
      },
      child: Container(
        padding: const EdgeInsets.only(top: 5, left: 5, bottom: 7, right: 16),
        margin: const EdgeInsets.only(bottom: 10),
        decoration:
            BoxDecoration(color: whiteColor, borderRadius: BorderRadius.circular(20), boxShadow: const [BoxShadow(color: grayBlurColor, offset: Offset(0, 0), blurRadius: 0.2)]),
        child: Row(
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 141,
                height: 90,
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  trip.imgPath,
                  fit: BoxFit.cover,
                )),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  firstLine(context),
                  const SizedBox(
                    height: 5,
                  ),
                  secondLine(context),
                  const SizedBox(
                    height: 5,
                  ),
                  thirdLine(context),
                  const SizedBox(
                    height: 5,
                  ),
                  ContainerButton(
                      title: "Book Now",
                      colorContainer: mainColor,
                      paddingHorizontal: 20,
                      titleStyle: whiteTextW4Style.copyWith(fontSize: 9),
                      borderRadius: 20,
                      paddingVertical: 4,
                      margin: const EdgeInsets.all(0))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Row firstLine(BuildContext context) {
    return Row(
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
      ],
    );
  }
}
