import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelling_app/bloc/location_bloc.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/const/fonts.dart';
import 'package:travelling_app/modules/explore_details.dart';
import 'package:travelling_app/widgets/explore_screen/location_container.dart';

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
          style: blackTextW7Style.copyWith(fontSize: 36),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: SvgPicture.asset('$imagePathLdpi/notify_icon.svg'),
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
        padding: const EdgeInsets.only(top: 12, bottom: 12, right: 18, left: 8),
        child: Row(
          children: [
            Image.asset("$imagePathLdpi/send.png"),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Start",
              style: whiteTextW4Style.copyWith(fontSize: 13),
            )
          ],
        ),
      ),
    );
  }

  Widget indicatorPageView(int currentIndex) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 18),
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
      margin: const EdgeInsets.only(right: 3),
      width: index == currentIndex ? 20 : 10,
      height: 6,
      decoration: BoxDecoration(
        color: index == currentIndex ? mainColor : grayColor,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
