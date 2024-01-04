import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelling_app/home/data/models/trip.dart';

class IsFavorite extends Cubit<List<Trip>> {
  IsFavorite() : super([]);
  var isFavorite = false;
  void toggleFavorite(Trip trip) {
    if (state.contains(trip)) {
      emit(state.where((e) => e.id != trip.id).toList());

      isFavorite = false;
    } else {
      emit([...state, trip]);
      isFavorite = true;
    }
  }
}
