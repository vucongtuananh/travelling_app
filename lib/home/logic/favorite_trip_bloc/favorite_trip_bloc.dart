import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelling_app/home/data/fire_store/fire_store.dart';
import 'package:travelling_app/home/data/models/trip.dart';
import 'package:travelling_app/home/logic/favorite_trip_bloc/favorite_trip_event.dart';
import 'package:travelling_app/home/logic/favorite_trip_bloc/favorite_trip_state.dart';

class FavoriteTripBloc extends Bloc<TripFavoriteEvent, TripFavoriteState> {
  final FireStoreData fireStoreData;

  List<Trip> listTrip = [];

  bool isFavorite = false;
  FavoriteTripBloc({
    required this.fireStoreData,
  }) : super(FavoriteTripInitialState()) {
    on<FavoriteTripAdd>((event, emit) async {
      emit(FavoriteTripLoadingState());

      await fireStoreData.updateFavoriteTripStatus(id: event.trip.id, data: {
        "isFavorite": true,
      });

      emit(FavoriteTripState(trip: event.trip));
    });
    on<FavoriteTripRemove>((event, emit) async {
      emit(FavoriteTripLoadingState());

      await fireStoreData.updateFavoriteTripStatus(id: event.trip.id, data: {
        "isFavorite": false,
      });
      emit(UnfavoriteTripState(trip: event.trip));
    });
  }
}
