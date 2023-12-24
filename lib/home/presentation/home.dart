import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelling_app/bloc/top_trip_bloc.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/home/data/fire_store/fire_store.dart';
import 'package:travelling_app/home/data/models/trip.dart';
import 'package:travelling_app/home/logic/home_bloc/home_bloc.dart';
import 'package:travelling_app/home/logic/home_bloc/home_event.dart';
import 'package:travelling_app/home/logic/search_bloc/search_bloc.dart';
import 'package:travelling_app/home/presentation/widgets/group_trips.dart';
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
  final TextEditingController _searchController = TextEditingController();
  _getDataTrip() async {
    final listData = await _fireStoreData.getData();
    setState(() {
      _listTrip = listData;
    });
  }

  Future<void> _pullRefresh() async {
    // await Future.delayed(const Duration(microseconds: 1));
  }

  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();

    _getDataTrip();
    if (_searchController.text.isEmpty) {
      if (_overlayEntry != null) {
        _overlayEntry!.remove();
      }
    }

    // _overlayEntry = _createOverlayEntry(context: context);
  }

  @override
  void didChangeDependencies() {
    // context.read<HomeBloc>().add(HomeReStartEvent(trip: );
    super.didChangeDependencies();
  }

  // OverlayEntry _createOverlayEntry({required BuildContext context}) {
  //   RenderBox renderBox = context.findRenderObject() as RenderBox;
  //   var size = renderBox.size;
  //   var offset = renderBox.localToGlobal(Offset.zero);

  //   return OverlayEntry(
  //     builder: (_) {
  //       final _searchBloc = context.read<SearchBloc>().state;

  //       if (_searchBloc is SearchSuccessState) {
  //         return Positioned(
  //           left: offset.dx,
  //           top: size.height + 5.0,
  //           width: size.width,
  //           child: Material(
  //             elevation: 1.0,
  //             child: ListView.builder(
  //               padding: EdgeInsets.zero,
  //               shrinkWrap: true,
  //               itemBuilder: (context, index) => Text(_searchBloc.listTripSearch[index].title),
  //               itemCount: _searchBloc.listTripSearch.length,
  //             ),
  //           ),
  //         );
  //       }
  //       if (_searchBloc is SearchLoadingState) {
  //         return Positioned(
  //           left: offset.dx,
  //           top: size.height + 5.0,
  //           width: size.width,
  //           child: const Material(elevation: 1.0, child: Center(child: CircularProgressIndicator())),
  //         );
  //       }
  //       return const SizedBox();
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _pullRefresh(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20, left: 20, right: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                header(context),
                const SizedBox(
                  height: 20,
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
        BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchSuccessState) {
              for (var t in state.listTripSearch) {
                print(t.title);
              }
            }
            return Expanded(
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
                        // onTap: () {
                        //   Overlay.of(context).insert(_overlayEntry!);
                        // },
                        onChanged: (value) {
                          context.read<SearchBloc>().add(SearchStartEvent(input: _searchController.text));
                        },
                        controller: _searchController,
                        decoration: const InputDecoration(border: InputBorder.none, hintText: "Search"),
                      );
                    }),
                  )
                ]),
              ),
            );
          },
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
          searchBar(context),
          SizedBox(
            width: 250,
            height: 250,
            child: Stack(
              children: <Widget>[
                Container(
                  width: 250,
                  height: 250,
                  color: Colors.white,
                ),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Colors.black.withAlpha(0), Colors.black12, Colors.black45],
                    ),
                  ),
                  child: const Text(
                    'Foreground Text',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ],
            ),
          )
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
          constraints: const BoxConstraints(maxHeight: 250, minHeight: 100),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return BlocProvider(
                create: (context) => HomeBloc(fireStoreData: _fireStoreData),
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
