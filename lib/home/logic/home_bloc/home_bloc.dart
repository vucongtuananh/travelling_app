import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelling_app/home/data/fire_store/fire_store.dart';
import 'package:travelling_app/home/data/models/trip.dart';
import 'package:travelling_app/home/logic/home_bloc/home_event.dart';
import 'package:travelling_app/home/logic/home_bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FireStoreData fireStoreData;
  late bool _isFavorite;
  late bool _isCheckFavorite;
  List<Trip> listTrip = [];

  bool isFavorite = false;
  HomeBloc({
    required this.fireStoreData,
  }) : super(HomeInitialState()) {
    on<HomeMakeFavoriteTripEvent>((event, emit) async {
      emit(HomeLoadingState());

      _isFavorite = await fireStoreData.toggleFavorite(trip: event.trip);

      emit(HomeFavoriteTripState(
        isFavorite: _isFavorite,
        id: event.trip.id,
      ));
    });
    on<HomeReStartEvent>((event, emit) async {
      emit(HomeLoadingState());

      _isCheckFavorite = await fireStoreData.checkFavoriteTrip(idtrip: event.trip.id);

      emit(HomeStartFavoriteTripState(
        isFavorite: _isCheckFavorite,
        id: event.trip.id,
      ));
    });
  }
}

// class HomeCubit extends Cubit<HomeState> {
//   HomeCubit() : super(HomeState());

//   void onClickFavorite() {
//     emit(state.copyWith(isFavorite: true));
//   }
// }
