import 'package:equatable/equatable.dart';

abstract class TripFavoriteState extends Equatable {}

class FavoriteTripInitialState extends TripFavoriteState {
  @override
  List<Object?> get props => [];
}

class FavoriteTripLoadingState extends TripFavoriteState {
  @override
  List<Object?> get props => [];
}

class FavoriteTripLoadedState extends TripFavoriteState {
  final bool isFavorite;
  final String id;
  FavoriteTripLoadedState({required this.isFavorite, required this.id});
  @override
  List<Object?> get props => [isFavorite, id];
}

class FavoriteTripCheckState extends TripFavoriteState {
  final bool isFavorite;
  final String id;
  FavoriteTripCheckState({required this.isFavorite, required this.id});

  @override
  List<Object?> get props => [isFavorite, id];
}
