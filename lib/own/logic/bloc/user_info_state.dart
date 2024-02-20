part of 'user_info_bloc.dart';

sealed class UserInfoState extends Equatable {
  const UserInfoState();

  @override
  List<Object> get props => [];
}

final class UserInfoInitial extends UserInfoState {}

final class UserInfoLoadedSuccess extends UserInfoState {
  final UserModel user;

  UserInfoLoadedSuccess({required this.user});
}

final class UserInfoLoadingState extends UserInfoState {}

final class UserInfoErrorState extends UserInfoState {
  final String error;
  final bool isError;

  UserInfoErrorState({required this.error, required this.isError});
  @override
  // TODO: implement props
  List<Object> get props => [error, isError];
}

final class UserInfoPickedImage extends UserInfoState {}
