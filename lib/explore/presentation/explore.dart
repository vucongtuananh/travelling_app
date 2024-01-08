import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelling_app/bloc/location_bloc.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/const/fonts.dart';
import 'package:travelling_app/explore/presentation/explore_details.dart';
import 'package:travelling_app/explore/presentation/location_container.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Explore",
          style: blackTextW7Style.copyWith(fontSize: 36.sp),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 30.w),
            child: SizedBox(width: 18.w, height: 21.h, child: SvgPicture.asset('$imagePathLdpi/notify_icon.svg')),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            indicatorPageView(_currentIndex),
            Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.2,
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 2.5,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: Image.asset("$imagePathLdpi/map.png"),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: PageView.builder(
                    itemBuilder: (context, index) {
                      return LocationContainer(location: listLocation[index]);
                    },
                    itemCount: listLocation.length,
                    onPageChanged: (value) {
                      setState(() {
                        _currentIndex = value;
                      });
                    },
                  ),
                ),
                Positioned(left: 23, bottom: 24, child: startLocation(_currentIndex))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget startLocation(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ExploreDetails(
                      location: listLocation[index],
                    )));
      },
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20), gradient: const LinearGradient(colors: linearMainColor, begin: Alignment.topLeft, end: Alignment.bottomRight)),
        padding: EdgeInsets.only(top: 12.h, bottom: 12.h, right: 18.w, left: 8.w),
        child: Row(
          children: [
            Image.asset("$imagePathLdpi/send.png"),
            SizedBox(
              width: 5.w,
            ),
            Text(
              "Start",
              style: whiteTextW4Style.copyWith(fontSize: 13.sp),
            )
          ],
        ),
      ),
    );
  }

  Widget indicatorPageView(int currentIndex) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, top: 10.h, bottom: 18.h),
      child: Row(
        children: [
          indicatorContainer(0, currentIndex),
          indicatorContainer(1, currentIndex),
          indicatorContainer(2, currentIndex),
        ],
      ),
    );
  }

  Widget indicatorContainer(int index, int currentIndex) {
    return Container(
      margin: EdgeInsets.only(right: 3.w),
      width: index == currentIndex ? 20.w : 10.w,
      height: 6,
      decoration: BoxDecoration(
        color: index == currentIndex ? mainColor : grayColor,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
