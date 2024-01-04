import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelling_app/home/data/fire_store/fire_store.dart';
import 'package:travelling_app/home/data/models/trip.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  FireStoreData fireStoreData = FireStoreData(currentUserId: FirebaseAuth.instance.currentUser!.uid);
  SearchBloc() : super(SearchInitial()) {
    on<SearchStartEvent>((event, emit) async {
      emit(SearchLoadingState());
      final listTrip = await fireStoreData.getData();
      final listData = listTrip.where(
        (trip) {
          return trip.title[0].toLowerCase() == event.input.trim().toLowerCase() || trip.title.trim().contains(event.input.toLowerCase());
        },
      ).toList();
      emit(SearchSuccessState(listTripSearch: listData));
    });
  }
}
