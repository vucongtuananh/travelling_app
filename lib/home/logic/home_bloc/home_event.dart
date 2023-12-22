import 'package:travelling_app/home/data/models/trip.dart';

abstract class HomeEvent {}

class HomeStartEvent extends HomeEvent {}

class HomeMakeFavoriteTripEvent extends HomeEvent {
  final Trip trip;
  HomeMakeFavoriteTripEvent({required this.trip});
}

class HomeReStartEvent extends HomeEvent {
  final Trip trip;
  HomeReStartEvent({required this.trip});
}
