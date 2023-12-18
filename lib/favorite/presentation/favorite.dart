import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  FireStoreData _fireStoreData = FireStoreData(currentUserId: FirebaseAuth.instance.currentUser!.uid);

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
            centerTitle: true,
            title: Text(
              "Saved Trips",
              style: grayTextW6Style.copyWith(color: const Color(0xff323232), fontSize: 16),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Events",
                      style: blackTextW6Style.copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
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
