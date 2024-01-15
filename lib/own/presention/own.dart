import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/const/fonts.dart';
import 'package:travelling_app/home/data/fire_store/fire_store.dart';
import 'package:travelling_app/login/data/auth/fire_auth.dart';
import 'package:travelling_app/signup/data/models/user.dart';

class OwnDetailScreen extends StatefulWidget {
  const OwnDetailScreen({super.key});

  @override
  State<OwnDetailScreen> createState() => _OwnDetailScreenState();
}

class _OwnDetailScreenState extends State<OwnDetailScreen> {
  final Auth _auth = Auth();
  final FireStoreData _fireStoreData = FireStoreData(currentUserId: FirebaseAuth.instance.currentUser!.uid);
  UserModel _userModel = UserModel(email: "email", name: "name", uid: FirebaseAuth.instance.currentUser!.uid, pass: '');
  getUserInfor() async {
    final _user = await _fireStoreData.getUserInfor();
    setState(() {
      _userModel = _user!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: blackTextW7Style.copyWith(fontSize: 36.sp),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 30.w),
            child: SizedBox(width: 18.w, height: 21.h, child: SvgPicture.asset('$imagePathLdpi/notify_icon.svg')),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Center(
          child: Column(
            children: [
              header(),
              TextButton(
                  onPressed: () {
                    _auth.logOut();
                  },
                  child: Text("logut"))
            ],
          ),
        ),
      ),
    );
  }

  header() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(text: "User Name :\t", style: blackTextW6Style, children: [
                TextSpan(
                  text: _userModel.name,
                  style: grayTextW6Style,
                )
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(text: "Email :\t", style: blackTextW6Style, children: [
                TextSpan(
                  text: _userModel.email,
                )
              ]),
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
        CircleAvatar(
          backgroundColor: mainColor,
          child: Text("Avt"),
          radius: 20,
        )
      ],
    );
  }
}
