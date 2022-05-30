import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:videocookie_flutter/view/List.dart';

import '../model/SearchType.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int bottomSelectedIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        List(),
      ],
    );
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }


  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('비디오쿠키'),
      ),
      endDrawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(130, 66, 34, 1),
              ),
              child: Text('온석태 님'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: buildPageView(),
      bottomNavigationBar:  BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: bottomSelectedIndex,
        onTap: (i) {
          setState(() {
            bottomSelectedIndex = i;
            bottomTapped(i);
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: '홈', activeIcon: Icon(Icons.home,color: Color.fromRGBO(130, 66, 34, 1),)),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: '장바구니', activeIcon: Icon(Icons.shopping_cart,color: Color.fromRGBO(130, 66, 34, 1),)),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: '설정', activeIcon: Icon(Icons.settings,color: Color.fromRGBO(130, 66, 34, 1),)),
        ],
      ),

    );

  }
}
