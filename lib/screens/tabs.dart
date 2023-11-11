import 'package:flutter/material.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/screens/explore.dart';
import 'package:travelling_app/screens/favorite.dart';
import 'package:travelling_app/screens/home.dart';
import 'package:travelling_app/screens/message.dart';
import 'package:travelling_app/screens/own.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [const HomeScreen(), const ExploreScreen(), const MessageScreen(), const FavoriteScreen(), const OwnDetailScreen()];

  void _chooseScreen(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  Widget iconButtonBottom(int currentIndex, String icon) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("$imagePathLdpi/$icon", color: _currentIndex == currentIndex ? mainColor : grayColor),
          const SizedBox(
            height: 5,
          ),
          _currentIndex == currentIndex ? Image.asset("$imagePathLdpi/point_blue.png") : const SizedBox()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: Container(
          height: 60,
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: grayColor, width: 0.5)),
          ),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                  },
                  icon: iconButtonBottom(0, "home.png")),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                  icon: iconButtonBottom(1, "max_location.png")),
              IconButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
                icon: iconButtonBottom(2, "message.png"),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 3;
                    });
                  },
                  icon: iconButtonBottom(3, "love.png")),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 4;
                    });
                  },
                  icon: iconButtonBottom(4, "profile.png")),
            ],
          ),
        ));
  }
}
