import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelling_app/bloc/top_trip_bloc.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/widgets/home_screen/group_trips.dart';
import 'package:travelling_app/widgets/home_screen/top_trips.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20, left: 20, right: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              header(),
              const SizedBox(
                height: 20,
              ),
              body()
            ],
          ),
        ),
      ),
    );
  }

  Widget searchBar() => Row(
        children: [
          Expanded(
            // flex: 5,
            child: Container(
              height: 45,
              decoration: BoxDecoration(color: whiteColor, border: Border.all(color: const Color(0xffE9E9E9)), borderRadius: BorderRadius.circular(20)),
              child: Row(children: [
                const SizedBox(
                  width: 15,
                ),
                SvgPicture.asset("$imagePathLdpi/search_icon.svg"),
                const SizedBox(
                  width: 8,
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(border: InputBorder.none, hintText: "Search"),
                  ),
                )
              ]),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            height: 45,
            width: 45,
            // padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(color: mainColor, borderRadius: BorderRadius.circular(10)),
            child: Image.asset("$imagePathLdpi/setting.png"),
          )
        ],
      );
  Widget header() => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Location",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: grayColor, fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    child: Row(
                      children: [
                        SvgPicture.asset("$imagePathLdpi/location_icon.svg"),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          "New York, USA",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: blackColor, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SvgPicture.asset("$imagePathLdpi/drop_arrow.svg"),
                      ],
                    ),
                  )
                ],
              ),
              SvgPicture.asset('$imagePathLdpi/notify_icon.svg')
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                // flex: 5,
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(color: whiteColor, border: Border.all(color: const Color(0xffE9E9E9)), borderRadius: BorderRadius.circular(20)),
                  child: Row(children: [
                    const SizedBox(
                      width: 15,
                    ),
                    SvgPicture.asset("$imagePathLdpi/search_icon.svg"),
                    const SizedBox(
                      width: 8,
                    ),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none, hintText: "Search"),
                      ),
                    )
                  ]),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                height: 45,
                width: 45,
                // padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(color: mainColor, borderRadius: BorderRadius.circular(10)),
                child: Image.asset("$imagePathLdpi/setting.png"),
              )
            ],
          ),
        ],
      );
  Widget body() {
    return Column(
      children: [
        categoryMenu(),
        const SizedBox(
          height: 30,
        ),
        topTrip(),
        const SizedBox(
          height: 30,
        ),
        groupTrip(),
      ],
    );
  }

  Widget categoryChoose({required imagePath, required String title, required int currentIndex}) {
    return Container(
      margin: const EdgeInsets.only(right: 3),
      height: 40,
      decoration:
          BoxDecoration(color: whiteColor, borderRadius: BorderRadius.circular(30), border: Border.all(color: _currentIndex == currentIndex ? mainColor : const Color(0xffE9E9E9))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(color: _currentIndex == currentIndex ? mainColor : whiteColor, borderRadius: BorderRadius.circular(30)),
            child: Image.asset(
              "$imagePathLdpi/$imagePath",
              color: _currentIndex == currentIndex ? whiteColor : mainColor,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: blackColor, fontSize: 12, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }

  Widget categoryMenu() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Categories",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: blackColor, fontSize: 16, fontWeight: FontWeight.w700),
            ),
            Text(
              "See All",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xffA2A2A2), fontSize: 14, fontWeight: FontWeight.w400),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
            height: 40,
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                  },
                  child: categoryChoose(
                    currentIndex: 0,
                    title: "Lake",
                    imagePath: "location_1.png",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                  child: categoryChoose(
                    currentIndex: 1,
                    title: "Sea",
                    imagePath: "location_2.png",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = 2;
                    });
                  },
                  child: categoryChoose(
                    currentIndex: 2,
                    title: "Mountain",
                    imagePath: "location_3.png",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = 3;
                    });
                  },
                  child: categoryChoose(
                    currentIndex: 3,
                    title: "Forest",
                    imagePath: "location_4.png",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = 4;
                    });
                  },
                  child: categoryChoose(
                    currentIndex: 4,
                    title: "Beach",
                    imagePath: "location_5.png",
                  ),
                ),
              ],
            ))
      ],
    );
  }

  Widget topTrip() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Top Trips",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: blackColor, fontSize: 16, fontWeight: FontWeight.w700),
            ),
            Text(
              "See All",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xffA2A2A2), fontSize: 14, fontWeight: FontWeight.w400),
            )
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 260, minHeight: 100),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return TopTrip(trip: listTrips[index]);
            },
            itemCount: listTrips.length,
          ),
        )
      ],
    );
  }

  Widget groupTrip() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Group Trips",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: blackColor, fontSize: 16, fontWeight: FontWeight.w700),
            ),
            Text(
              "See All",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xffA2A2A2), fontSize: 14, fontWeight: FontWeight.w400),
            )
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        GroupTripCard(groupTrip: listGroupTrips[0])
      ],
    );
  }
}
