import 'package:equatable/equatable.dart';
import 'package:travelling_app/home/data/models/trip.dart';

abstract class HomeState extends Equatable {}

class HomeInitialState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoadedState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeFavoriteTripState extends HomeState {
  final List<Trip> listTrip;
  final bool isFavorite;
  HomeFavoriteTripState({required this.isFavorite, required this.listTrip});
  @override
  List<Object?> get props => [];
}
