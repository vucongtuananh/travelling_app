import 'package:travelling_app/home/data/models/trip.dart';

abstract class TripFavoriteEvent {}

class FavoriteTripMarkEvent extends TripFavoriteEvent {
  final Trip trip;
  FavoriteTripMarkEvent({required this.trip});
}

class TripFavoriteRestartEvent extends TripFavoriteEvent {
  final Trip trip;
  TripFavoriteRestartEvent({required this.trip});
}
