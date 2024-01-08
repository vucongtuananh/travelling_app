part of 'search_user_bloc.dart';

sealed class SearchUserEvent extends Equatable {
  const SearchUserEvent();

  @override
  List<Object> get props => [];
}

class StartSearchUserEvent extends SearchUserEvent {
  final String input;

  const StartSearchUserEvent({required this.input});
}
