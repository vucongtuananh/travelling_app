import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelling_app/modules/home_screen/home_event.dart';
import 'package:travelling_app/modules/home_screen/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {}
}
