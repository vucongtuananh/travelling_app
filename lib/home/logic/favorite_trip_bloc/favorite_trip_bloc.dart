import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelling_app/home/data/fire_store/fire_store.dart';
import 'package:travelling_app/home/data/models/trip.dart';
import 'package:travelling_app/home/logic/favorite_trip_bloc/favorite_trip_event.dart';
import 'package:travelling_app/home/logic/favorite_trip_bloc/favorite_trip_state.dart';

class FavoriteTripBloc extends Bloc<TripFavoriteEvent, TripFavoriteState> {
  final FireStoreData fireStoreData;
  late bool _isFavorite;
  late bool _isCheckFavorite;
  List<Trip> listTrip = [];

  bool isFavorite = false;
  FavoriteTripBloc({
    required this.fireStoreData,
  }) : super(FavoriteTripInitialState()) {
    on<FavoriteTripMarkEvent>((event, emit) async {
      emit(FavoriteTripLoadingState());

      _isFavorite = await fireStoreData.toggleFavorite(trip: event.trip);

      emit(FavoriteTripLoadedState(
        isFavorite: _isFavorite,
        id: event.trip.id,
      ));
    });
    on<TripFavoriteRestartEvent>((event, emit) async {
      emit(FavoriteTripLoadingState());

      _isCheckFavorite = await fireStoreData.checkFavoriteTrip(idtrip: event.trip.id);

      emit(FavoriteTripCheckState(
        isFavorite: _isCheckFavorite,
        id: event.trip.id,
      ));
    });
  }
}

// class HomeCubit extends Cubit<TripFavoriteState> {
//   HomeCubit() : super(TripFavoriteState());

//   void onClickFavorite() {
//     emit(state.copyWith(isFavorite: true));
//   }
// }
