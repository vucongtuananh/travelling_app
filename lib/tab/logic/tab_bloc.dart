import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelling_app/home/data/models/trip.dart';
import 'package:travelling_app/tab/logic/tab_event.dart';
import 'package:travelling_app/tab/logic/tab_state.dart';

class TabBLoc extends Bloc<TabEvent, TabState> {
  final List<Trip> listTrip;
  TabBLoc({required this.listTrip}) : super(TabInitialState());
}
