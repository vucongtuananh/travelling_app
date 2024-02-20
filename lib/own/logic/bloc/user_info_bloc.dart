import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travelling_app/signup/data/models/user.dart';

import '../../data/user_info_service.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final UserInforService userInforService;
  UserInfoBloc({required this.userInforService}) : super(UserInfoInitial()) {
    on<UserInfoStartEvent>(_userInfoStartEvent);
    on<UserInfoTextChangeEvent>(_userInfoTextChangeEvent);
    on<UserInfoSubmit>(_userInfoSubmit);
    on<UserInfoImagePickerEvent>(_userInfoImagePicker);
  }

  FutureOr<void> _userInfoStartEvent(UserInfoStartEvent event, Emitter<UserInfoState> emit) async {
    emit(UserInfoLoadingState());
    final user = await userInforService.getUserInfor();
    emit(UserInfoLoadedSuccess(user: user));
  }

  FutureOr<void> _userInfoTextChangeEvent(UserInfoTextChangeEvent event, Emitter<UserInfoState> emit) {
    if (event.textChange.isEmpty) {
      emit(UserInfoErrorState(error: "khong duoc bo trong ten", isError: true));
    } else {
      emit(UserInfoErrorState(error: "", isError: false));
    }
  }

  FutureOr<void> _userInfoSubmit(UserInfoSubmit event, Emitter<UserInfoState> emit) async {
    emit(UserInfoLoadingState());
    if (event.urlAvatar == null) {
      await userInforService.changeUserInfor(event.text, event.avatar);
      final user = await userInforService.getUserInfor();
      emit(UserInfoLoadedSuccess(user: user));
    } else {
      final urlImg = await userInforService.pushAndGetUrlImage(event.urlAvatar!);
      await userInforService.changeUserInfor(event.text, urlImg);
      final user = await userInforService.getUserInfor();
      emit(UserInfoLoadedSuccess(user: user));
    }
  }

  FutureOr<void> _userInfoImagePicker(UserInfoImagePickerEvent event, Emitter<UserInfoState> emit) {
    emit(UserInfoPickedImage());
  }
}
