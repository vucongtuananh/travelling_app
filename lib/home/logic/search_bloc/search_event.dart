part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  final String input;

  const SearchEvent({required this.input});

  @override
  List<Object> get props => [input];
}

final class SearchStartEvent extends SearchEvent {
  const SearchStartEvent({required super.input});
}
