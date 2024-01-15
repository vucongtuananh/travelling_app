import 'package:travelling_app/home/data/models/trip.dart';

abstract class TripFavoriteEvent {}

class FavoriteTripAdd extends TripFavoriteEvent {
  final Trip trip;
  FavoriteTripAdd({required this.trip});
}

class FavoriteTripRemove extends TripFavoriteEvent {
  final Trip trip;

  FavoriteTripRemove({required this.trip});
}

class TripFavoriteRestartEvent extends TripFavoriteEvent {
  final Trip trip;
  TripFavoriteRestartEvent({required this.trip});
}
