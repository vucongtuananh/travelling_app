part of 'user_info_bloc.dart';

sealed class UserInfoEvent extends Equatable {
  const UserInfoEvent();

  @override
  List<Object> get props => [];
}

class UserInfoStartEvent extends UserInfoEvent {}

class UserInfoTextChangeEvent extends UserInfoEvent {
  final String textChange;

  UserInfoTextChangeEvent({required this.textChange});
}

class UserInfoSubmit extends UserInfoEvent {
  final String text;
  final File? urlAvatar;
  final String? avatar;
  UserInfoSubmit({required this.text, required this.urlAvatar, required this.avatar});
}

class UserInfoImagePickerEvent extends UserInfoEvent {}
