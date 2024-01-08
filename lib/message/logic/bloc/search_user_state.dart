part of 'search_user_bloc.dart';

sealed class SearchUserState extends Equatable {
  const SearchUserState();

  @override
  List<Object> get props => [];
}

final class SearchUserInitial extends SearchUserState {}

final class SearchUserLoading extends SearchUserState {}

final class SearchUserLoaded extends SearchUserState {
  final List<UserModel> listUser;

  const SearchUserLoaded({required this.listUser});
}
