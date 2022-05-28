import 'package:flutter/material.dart';
import 'package:identity_project/utils/colors.dart';
import 'package:identity_project/utils/global_variables.dart';
import 'package:identity_project/widgets/image_logo.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
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
    setState(() {
      _page = page;
    });
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 125,
        backgroundColor: appYellowColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 45),
              child: SizedBox(
                height: 250, // Your Height
                width: 250, // Your width
                child: ImageLogo(
                    height: 300, logoType: 'brandname', textColor: 'white'),
              ),
            ),
            // Your widgets here
          ],
        ),
        actions: [
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                      bottom: screenWidth > webScreenSize ? 10 : 0),
                  icon: Icon(
                    Icons.home,
                    color: _page == 0 ? pinkColor : appBlackColor,
                    size: _page == 0 ? 50 : 30,
                  ),
                  onPressed: () => navigationTapped(0),
                ),
                const SizedBox(
                  width: 50,
                ),
                IconButton(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                      bottom: screenWidth > webScreenSize ? 10 : 0),
                  icon: Icon(
                    Icons.search,
                    color: _page == 1 ? pinkColor : appBlackColor,
                    size: _page == 1 ? 50 : 30,
                  ),
                  onPressed: () => navigationTapped(1),
                ),
                const SizedBox(
                  width: 50,
                ),
                IconButton(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                      bottom: screenWidth > webScreenSize ? 10 : 0),
                  icon: Icon(
                    Icons.add_circle,
                    color: _page == 2 ? pinkColor : appBlackColor,
                    size: _page == 2 ? 50 : 30,
                  ),
                  onPressed: () => navigationTapped(2),
                ),
                const SizedBox(
                  width: 50,
                ),
                IconButton(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                      bottom: screenWidth > webScreenSize ? 10 : 0),
                  icon: Icon(
                    Icons.favorite,
                    color: _page == 3 ? pinkColor : appBlackColor,
                    size: _page == 3 ? 50 : 30,
                  ),
                  onPressed: () => navigationTapped(3),
                ),
                const SizedBox(
                  width: 50,
                ),
                IconButton(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                      bottom: screenWidth > webScreenSize ? 10 : 0),
                  icon: Icon(
                    Icons.person_rounded,
                    color: _page == 4 ? pinkColor : appBlackColor,
                    size: _page == 4 ? 50 : 30,
                  ),
                  onPressed: () => navigationTapped(4),
                ),
                const SizedBox(
                  width: 50,
                ),
              ],
            ),
          ),
        ],
      ),
      body: PageView(
        children: appScreens,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
    );
  }
}
