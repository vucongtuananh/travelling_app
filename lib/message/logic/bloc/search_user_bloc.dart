import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travelling_app/message/data/sources/user_service.dart';
import 'package:travelling_app/signup/data/models/user.dart';

part 'search_user_event.dart';
part 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  final UserService userService;
  SearchUserBloc({required this.userService}) : super(SearchUserInitial()) {
    on<StartSearchUserEvent>((event, emit) async {
      emit(SearchUserLoading());
      final listUser = await userService.getUser();
      final listData = listUser.where(
        (user) {
          return user.name[0].toLowerCase() == event.input.trim().toLowerCase() || user.name.trim().contains(event.input.toLowerCase());
        },
      ).toList();
      emit(SearchUserLoaded(listUser: listData));
    });
  }
}
