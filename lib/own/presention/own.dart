import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/const/fonts.dart';
import 'package:travelling_app/login/data/auth/fire_auth.dart';
import 'package:travelling_app/own/data/user_info_service.dart';
import 'package:travelling_app/own/logic/bloc/user_info_bloc.dart';
import 'package:travelling_app/own/presention/user_change_info.dart';
import 'package:travelling_app/signup/data/models/user.dart';

class OwnDetailScreen extends StatefulWidget {
  const OwnDetailScreen({super.key});

  @override
  State<OwnDetailScreen> createState() => _OwnDetailScreenState();
}

class _OwnDetailScreenState extends State<OwnDetailScreen> {
  final Auth _auth = Auth();

  UserInfoBloc userInfoBloc = UserInfoBloc(userInforService: UserInforService());

  @override
  void initState() {
    // TODO: implement initState
    userInfoBloc.add(UserInfoStartEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: blackTextW7Style.copyWith(fontSize: 36.sp),
        ),
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.only(right: 30.w),
        //     child: SizedBox(width: 18.w, height: 21.h, child: SvgPicture.asset('$imagePathLdpi/notify_icon.svg')),
        //   )
        // ],
      ),
      body: BlocBuilder<UserInfoBloc, UserInfoState>(
        bloc: userInfoBloc,
        builder: (context, state) {
          if (state is UserInfoLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserInfoLoadedSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: Column(
                  children: [
                    header(state.user),
                    TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => UserChangeInfo(
                                        user: state.user,
                                        userInfoBloc: userInfoBloc,
                                      )));
                        },
                        icon: Icon(Icons.filter),
                        label: Text("Chinh sua")),
                    TextButton(
                        onPressed: () {
                          _auth.logOut();
                        },
                        child: Text("logut"))
                  ],
                ),
              ),
            );
          }

          if (state is UserInfoPickedImage) {
            return const Text("Bloc recently is PickedImage");
          }
          return const Text("Loi cu no roi");
        },
      ),
    );
  }

  header(UserModel user) {
    return Column(
      children: [
        Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                color: mainColor,
              ),
              clipBehavior: Clip.hardEdge,
              child: user.urlAvatar == ""
                  ? const Icon(Icons.person)
                  : Image.network(
                      user.urlAvatar!,
                      fit: BoxFit.cover,
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "User Name",
                  style: blackTextW6Style,
                ),
                SizedBox(width: 20.w),
                Text(user.name)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Email",
                  style: blackTextW6Style,
                ),
                SizedBox(width: 20.w),
                Text(user.email)
              ],
            ),
            SizedBox(
              width: 50,
              height: 20,
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(20),
                valueColor: const AlwaysStoppedAnimation<Color>(mainColor),
                semanticsLabel: "30",
                semanticsValue: "30",
                value: 30 / 100,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
