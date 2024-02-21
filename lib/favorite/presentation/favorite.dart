import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/fonts.dart';
import 'package:travelling_app/favorite/presentation/saved_trip.dart';
import 'package:travelling_app/home/data/fire_store/fire_store.dart';
import 'package:travelling_app/home/data/models/trip.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final FireStoreData _fireStoreData = FireStoreData(currentUserId: FirebaseAuth.instance.currentUser!.uid);

  List<Trip> _listFavorite = [];
  _getFavoriteTrip() async {
    final listFavorite = await _fireStoreData.getFavoriteTripList();
    setState(() {
      _listFavorite = listFavorite;
    });
  }

  @override
  void initState() {
    super.initState();
    _getFavoriteTrip();
  }

  @override
  Widget build(BuildContext context) {
    bool isBlank = _listFavorite.isEmpty;
    return RefreshIndicator(
      onRefresh: () => _getFavoriteTrip(),
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Saved Trips",
              style: blackTextW7Style.copyWith(fontSize: 36.sp),
            ),
            // actions: [
            //   Padding(
            //     padding: EdgeInsets.only(right: 30.w),
            //     child: SvgPicture.asset('$imagePathLdpi/notify_icon.svg'),
            //   )
            // ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      "Events",
                      style: blackTextW6Style.copyWith(fontSize: 16.sp),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    isBlank
                        ? const Center(child: Text("There's no saved events !!"))
                        : Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return SavedTrip(trip: _listFavorite[index]);
                              },
                              itemCount: _listFavorite.length,
                            ),
                          )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
