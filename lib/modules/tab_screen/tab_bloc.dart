import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelling_app/modules/tab_screen/tab_event.dart';
import 'package:travelling_app/modules/tab_screen/tab_state.dart';

class TabBLoc extends Bloc<TabEvent, TabState> {
  final String user;
  TabBLoc({required this.user}) : super(TabInitialState()) {}
}
