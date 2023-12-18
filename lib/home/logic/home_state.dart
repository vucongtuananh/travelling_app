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
  HomeFavoriteTripState({
    required this.isFavorite,
  });
  @override
  List<Object?> get props => [isFavorite];
}

class HomeStartFavoriteTripState extends HomeState {
  final bool isFavorite;
  HomeStartFavoriteTripState({required this.isFavorite});

  @override
  List<Object?> get props => [isFavorite];
}
