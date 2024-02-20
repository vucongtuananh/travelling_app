import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelling_app/own/logic/bloc/user_info_bloc.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({
    super.key,
    required this.userImagePicker,
    required this.imgUrl,
    required this.userInfoBloc,
  });

  final void Function(File imagePicker)? userImagePicker;
  final String? imgUrl;
  final UserInfoBloc userInfoBloc;
  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? selectedImage;
  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage == null) {
      return;
    }

    widget.userInfoBloc.add(UserInfoImagePickerEvent());
    setState(() {
      selectedImage = File(pickedImage.path);
    });
    widget.userImagePicker!(selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _takePicture,
        child: Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
          ),
          clipBehavior: Clip.hardEdge,
          child: selectedImage == null
              ? (widget.imgUrl == '' ? const Icon(Icons.person) : Image.network(widget.imgUrl!))
              : Image.file(
                  selectedImage!,
                  fit: BoxFit.cover,
                ),
        ));
  }
}
