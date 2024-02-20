import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/const/fonts.dart';
import 'package:travelling_app/own/logic/bloc/user_info_bloc.dart';
import 'package:travelling_app/own/presention/own.dart';
import 'package:travelling_app/own/presention/widgets/user_image_picker.dart';
import 'package:travelling_app/signup/data/models/user.dart';
import 'package:travelling_app/widgets/container_button.dart';

class UserChangeInfo extends StatefulWidget {
  const UserChangeInfo({super.key, required this.userInfoBloc, required this.user});
  final UserInfoBloc userInfoBloc;
  final UserModel user;

  @override
  State<UserChangeInfo> createState() => _UserChangeInfoState();
}

class _UserChangeInfoState extends State<UserChangeInfo> {
  @override
  void initState() {
    // widget.userInfoBloc.add(UserInfoStartEvent());
    super.initState();
    _nameController.text = widget.user.name;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  final TextEditingController _nameController = TextEditingController();
  File? selectedImage;

  Future<bool> onWillPop(BuildContext screenContext) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Ban co chac chan muon thoat?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  widget.userInfoBloc.add(UserInfoSubmit(text: _nameController.text, urlAvatar: selectedImage, avatar: widget.user.urlAvatar));
                  Navigator.pop(screenContext);
                },
                child: const Text("Okay")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No")),
          ],
        );
      },
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoBloc, UserInfoState>(
      bloc: widget.userInfoBloc,
      buildWhen: (previous, current) => current is UserInfoPickedImage,
      builder: (context, state) {
        return WillPopScope(
          onWillPop: (widget.userInfoBloc.state is UserInfoLoadedSuccess)
              ? () async {
                  return true;
                }
              : () => onWillPop(context),
          child: Scaffold(
              body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: header(widget.user),
            ),
          )),
        );
      },
    );
  }

  header(UserModel user) {
    return Row(
      children: [
        UserImagePicker(
          userImagePicker: (imagePicker) => selectedImage = imagePicker,
          imgUrl: user.urlAvatar,
          userInfoBloc: widget.userInfoBloc,
        ),
        SizedBox(
          width: 20.w,
        ),
        Expanded(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "User Name",
                    style: blackTextW6Style,
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: TextFormField(
                      controller: _nameController,
                      onChanged: (value) {
                        widget.userInfoBloc.add(UserInfoTextChangeEvent(textChange: _nameController.text));
                      },
                      decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.abc),
                          error: BlocBuilder<UserInfoBloc, UserInfoState>(
                            bloc: widget.userInfoBloc,
                            builder: (context, state) {
                              if (state is UserInfoErrorState) {
                                return Text(
                                  state.error,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                );
                              }
                              return const SizedBox();
                            },
                          )),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Email",
                    style: blackTextW6Style,
                  ),
                  SizedBox(width: 20.w),
                  Text(user.email)
                ],
              ),
              BlocConsumer<UserInfoBloc, UserInfoState>(
                listener: (context, state) {
                  if (state is UserInfoLoadedSuccess) {
                    Navigator.pop(context);
                  }
                },
                bloc: widget.userInfoBloc,
                builder: (context, state) {
                  if (state is UserInfoErrorState) {
                    var isError = state.isError;
                    return ContainerButton(
                        onPress: () => isError
                            ? null
                            : {
                                widget.userInfoBloc.add(UserInfoSubmit(text: _nameController.text, urlAvatar: selectedImage, avatar: user.urlAvatar)),
                              },
                        title: "Thay doi",
                        colorContainer: isError ? grayBlurColor : mainColor,
                        paddingHorizontal: 8,
                        titleStyle: isError ? blackTextW6Style.copyWith(color: mainColor) : whiteTextW6Style,
                        borderRadius: 20,
                        paddingVertical: 10,
                        margin: EdgeInsets.zero);
                  }
                  if (state is UserInfoLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ContainerButton(
                      onPress: () => widget.userInfoBloc.add(UserInfoSubmit(text: _nameController.text, urlAvatar: selectedImage, avatar: user.urlAvatar)),
                      title: "Thay doi",
                      colorContainer: mainColor,
                      paddingHorizontal: 8,
                      titleStyle: whiteTextW6Style,
                      borderRadius: 20,
                      paddingVertical: 10,
                      margin: EdgeInsets.zero);
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
