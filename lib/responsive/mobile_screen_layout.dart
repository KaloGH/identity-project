import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:identity_project/utils/colors.dart';
import 'package:identity_project/utils/global_variables.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _page);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appYellowColor,
      body: PageView(
        children: appScreens,
        //physics: const NeverScrollableScrollPhysics(), // Elimina el scroll entre paginas.
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        height: 60,
        iconSize: 30,
        backgroundColor: appYellowColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _page == 0 ? pinkColor : appBlackColor,
            ),
            label: '',
            backgroundColor: appBlackColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _page == 1 ? pinkColor : appBlackColor,
            ),
            label: '',
            backgroundColor: appBlackColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
              color: _page == 2 ? pinkColor : appWhiteColor,
            ),
            label: '',
            backgroundColor: appBlackColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: _page == 3 ? pinkColor : appBlackColor,
            ),
            label: '',
            backgroundColor: appBlackColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_rounded,
              color: _page == 4 ? pinkColor : appBlackColor,
            ),
            label: '',
            backgroundColor: appBlackColor,
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
