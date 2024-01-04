import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/const/fonts.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: SvgPicture.asset("$imagePathLdpi/back_arrow.svg"),
      //   actions: [SvgPicture.asset("$imagePathLdpi/take_note_icon.svg")],
      // ),
      body: Padding(
        padding: EdgeInsets.only(right: 24.w, left: 24.w, top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            header(),
            SizedBox(
              height: 20.h,
            ),
            searchBar(),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset("$imagePathLdpi/back_arrow.svg"),
        Text(
          "Chat Room",
          style: blackTextW6Style.copyWith(fontSize: 16.sp),
        ),
        SvgPicture.asset("$imagePathLdpi/take_note_icon.svg"),
      ],
    );
  }

  Widget searchBar() {
    return Container(
      padding: EdgeInsets.only(
        left: 17.w,
      ),
      decoration: BoxDecoration(
          border: Border.all(
            color: grayColor,
          ),
          borderRadius: BorderRadius.circular(30.r)),
      child: Row(
        children: [
          const Icon(Icons.search),
          SizedBox(
            width: 5.w,
          ),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(hintText: "Search", border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}
