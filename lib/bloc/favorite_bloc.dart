import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelling_app/models/trip.dart';

class IsFavorite extends Cubit<List<Trip>> {
  IsFavorite() : super([]);

  bool toggleFavorite(Trip trip) {
    if (state.contains(trip)) {
      emit(state.where((element) => element.id != trip.id).toList());
      return false;
    } else {
      emit([...state, trip]);
      return true;
    }
  }
}
