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

  @override
  Widget build(BuildContext context) {
    List<String> keys = _pages.keys.toList();
    return Scaffold(
      body: _pages[keys[_currentIndex]],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: mainColor,
          unselectedItemColor: grayColor,
          currentIndex: _currentIndex,
          onTap: _chooseScreen,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  "$imagePathLdpi/home.png",
                  color: grayColor,
                ),
                label: "."),
            BottomNavigationBarItem(icon: Image.asset("$imagePathLdpi/home.png", color: grayColor), label: "."),
            BottomNavigationBarItem(icon: Image.asset("$imagePathLdpi/home.png", color: grayColor), label: "."),
            BottomNavigationBarItem(icon: Image.asset("$imagePathLdpi/home.png", color: grayColor), label: "."),
            BottomNavigationBarItem(icon: Image.asset("$imagePathLdpi/home.png", color: grayColor), label: "."),
          ]),
    );
  }
}
