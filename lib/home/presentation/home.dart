import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelling_app/bloc/top_trip_bloc.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/home/data/fire_store/fire_store.dart';
import 'package:travelling_app/home/data/models/trip.dart';
import 'package:travelling_app/home/logic/favorite_trip_bloc/favorite_trip_bloc.dart';
import 'package:travelling_app/home/logic/favorite_trip_bloc/favorite_trip_event.dart';
import 'package:travelling_app/home/logic/search_bloc/search_bloc.dart';
import 'package:travelling_app/home/presentation/widgets/group_trips.dart';
import 'package:travelling_app/home/presentation/widgets/search_screen.dart';
import 'package:travelling_app/home/presentation/widgets/top_trips.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentIndex = 0;
  final FireStoreData _fireStoreData = FireStoreData(currentUserId: FirebaseAuth.instance.currentUser!.uid);
  late List<Trip> _listTrip = [];
  final TextEditingController searchController = TextEditingController();
  _getDataTrip() async {
    final listData = await _fireStoreData.getData();
    setState(() {
      _listTrip = listData;
    });
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(const Duration(microseconds: 1));
    for (var i in _listTrip) {
      if (!mounted) return;
      context.read<FavoriteTripBloc>().add(TripFavoriteRestartEvent(trip: i));
    }
  }

  @override
  void initState() {
    super.initState();

    _getDataTrip();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _pullRefresh(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20.h, left: 20.w, right: 20.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                header(context),
                SizedBox(
                  height: 20.h,
                ),
                body()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchBar(BuildContext context) {
    return Row(
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
              const Icon(Icons.search),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Builder(builder: (context) {
                  return TextField(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => BlocProvider.value(value: BlocProvider.of<SearchBloc>(context), child: SearchScreen(searchController: searchController))));
                    },
                    onChanged: (value) {
                      context.read<SearchBloc>().add(SearchStartEvent(input: searchController.text));
                    },
                    controller: searchController,
                    decoration: const InputDecoration(border: InputBorder.none, hintText: "Search"),
                  );
                }),
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
  }

  Widget header(BuildContext context) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Location",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: grayColor, fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    child: Row(
                      children: [
                        SvgPicture.asset("$imagePathLdpi/location_icon.svg"),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          "New York, USA",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: blackColor, fontSize: 16.sp, fontWeight: FontWeight.w600),
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
          SizedBox(
            height: 20.h,
          ),
          searchBar(context),
        ],
      );
  Widget body() {
    return Column(
      children: [
        categoryMenu(),
        SizedBox(
          height: 30.h,
        ),
        topTrip(),
        SizedBox(
          height: 30.h,
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
              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: blackColor, fontSize: 16.sp, fontWeight: FontWeight.w700),
            ),
            Text(
              "See All",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xffA2A2A2), fontSize: 14.sp, fontWeight: FontWeight.w400),
            )
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        SizedBox(
            height: 40.h,
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
              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: blackColor, fontSize: 16.sp, fontWeight: FontWeight.w700),
            ),
            Text(
              "See All",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xffA2A2A2), fontSize: 14.sp, fontWeight: FontWeight.w400),
            )
          ],
        ),
        SizedBox(
          height: 25.h,
        ),
        SizedBox(
          height: 230.h,
          child: ListView.builder(
            // padding: EdgeInsets.symmetric(horizontal: 0),
            // shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return BlocProvider.value(
                value: FavoriteTripBloc(fireStoreData: _fireStoreData),
                child: TopTrip(trip: _listTrip[index]),
              );
            },
            itemCount: _listTrip.length,
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
              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: blackColor, fontSize: 16.sp, fontWeight: FontWeight.w700),
            ),
            Text(
              "See All",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xffA2A2A2), fontSize: 14.sp, fontWeight: FontWeight.w400),
            )
          ],
        ),
        SizedBox(
          height: 24.h,
        ),
        GroupTripCard(groupTrip: listGroupTrips[0])
      ],
    );
  }
}
