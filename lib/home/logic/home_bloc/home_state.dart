import 'package:equatable/equatable.dart';

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
  final bool isFavorite;
  final String id;
  HomeFavoriteTripState({required this.isFavorite, required this.id});
  @override
  List<Object?> get props => [isFavorite, id];
}

class HomeStartFavoriteTripState extends HomeState {
  final bool isFavorite;
  final String id;
  HomeStartFavoriteTripState({required this.isFavorite, required this.id});

  @override
  List<Object?> get props => [isFavorite, id];
}
