import 'package:equatable/equatable.dart';
import 'package:travelling_app/home/data/models/trip.dart';

abstract class TripFavoriteState extends Equatable {}

class FavoriteTripInitialState extends TripFavoriteState {
  @override
  List<Object?> get props => [];
}

class FavoriteTripLoadingState extends TripFavoriteState {
  @override
  List<Object?> get props => [];
}

class UnfavoriteTripState extends TripFavoriteState {
  final Trip trip;
  UnfavoriteTripState({required this.trip});
  @override
  List<Object?> get props => [];
}

class FavoriteTripState extends TripFavoriteState {
  final Trip trip;
  FavoriteTripState({required this.trip});
  @override
  List<Object?> get props => [trip];
}

class FavoriteTripCheckState extends TripFavoriteState {
  final bool isFavorite;
  final String id;
  FavoriteTripCheckState({required this.isFavorite, required this.id});

  @override
  List<Object?> get props => [isFavorite, id];
}
