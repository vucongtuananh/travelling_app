import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelling_app/home/data/fire_store/fire_store.dart';
import 'package:travelling_app/home/data/models/trip.dart';
import 'package:travelling_app/home/logic/home_event.dart';
import 'package:travelling_app/home/logic/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FireStoreData fireStoreData;
  List<Trip> listTrip = [];

  bool isFavorite = false;
  HomeBloc({
    required this.fireStoreData,
  }) : super(HomeInitialState()) {
    on<HomeMakeFavoriteTripEvent>((event, emit) {
      // await fireStoreData.favoriteData(event.trip);
      final bool _isFavorite = listTrip.contains(event.trip);
      if (_isFavorite) {
        isFavorite = false;
        listTrip = listTrip.where((element) => element.id != event.trip.id).toList();
        emit(HomeFavoriteTripState(isFavorite: isFavorite, listTrip: listTrip));
        print(listTrip);
      } else {
        isFavorite = true;
        listTrip.add(event.trip);
        emit(HomeFavoriteTripState(isFavorite: isFavorite, listTrip: listTrip));
        print(listTrip);
      }
    });
  }
}

// class HomeCubit extends Cubit<HomeState> {
//   HomeCubit() : super(HomeState());

//   void onClickFavorite() {
//     emit(state.copyWith(isFavorite: true));
//   }
// }
