import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelling_app/bloc/favorite_bloc.dart';
import 'package:travelling_app/const/fonts.dart';
import 'package:travelling_app/home/data/models/trip.dart';
import 'package:travelling_app/favorite/presentation/saved_trip.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IsFavorite(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Saved Trips",
            style: grayTextW6Style.copyWith(color: const Color(0xff323232), fontSize: 16),
          ),
        ),
        body: BlocBuilder<IsFavorite, List<Trip>>(
          builder: (context, state) {
            final isBlank = context.read<IsFavorite>().state.isEmpty;
            final listSavedTrips = context.read<IsFavorite>().state;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                  return SavedTrip(trip: listSavedTrips[index]);
                                },
                                itemCount: listSavedTrips.length,
                              ),
                            )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
