import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelling_app/const/assets_image.dart';
import 'package:travelling_app/const/color.dart';
import 'package:travelling_app/explore/presentation/explore.dart';
import 'package:travelling_app/favorite/presentation/favorite.dart';
import 'package:travelling_app/home/logic/search_bloc/search_bloc.dart';
import 'package:travelling_app/home/presentation/home.dart';
import 'package:travelling_app/message/data/sources/user_service.dart';
import 'package:travelling_app/message/logic/bloc/search_user_bloc.dart';
import 'package:travelling_app/message/presention/message_screen.dart';
import 'package:travelling_app/own/presention/own.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => SearchBloc(),
      )
    ], child: const HomeScreen()),
    const ExploreScreen(),
    RepositoryProvider(
      create: (context) => UserService(),
      child: BlocProvider(
        create: (context) => SearchUserBloc(userService: UserService()),
        child: const MessageScreen(),
      ),
    ),
    const FavoriteScreen(),
    const OwnDetailScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        body: IndexedStack(index: _currentIndex, children: _pages),
        // body: _pages[_currentIndex],
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
                  icon: iconButtonBottom(0, "home_icon.svg")),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                  icon: iconButtonBottom(1, "location_icon_tab.svg")),
              IconButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
                icon: iconButtonBottom(2, "message_icon.svg"),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 3;
                    });
                  },
                  icon: iconButtonBottom(3, "heart_icon_tab.svg")),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 4;
                    });
                  },
                  icon: iconButtonBottom(4, "profile_icon.svg")),
            ],
          ),
        ));
  }

  Widget iconButtonBottom(int currentIndex, String icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 22.7.w,
          height: 22.7.h,
          child: SvgPicture.asset(
            "$imagePathLdpi/$icon",
            color: _currentIndex == currentIndex ? mainColor : grayColor,
            width: 22,
            height: 22,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        _currentIndex == currentIndex
            ? SizedBox(
                width: 8.w,
                height: 8.h,
                child: SvgPicture.asset("$imagePathLdpi/dot_icon.svg"),
              )
            : const SizedBox()
      ],
    );
  }
}
