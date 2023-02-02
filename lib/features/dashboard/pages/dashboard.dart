
import 'package:bay/features/profile/pages/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../history/pages/history_dashboard.dart';
import '../../home/pages/home.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:PersistentTabView(
        decoration:NavBarDecoration(
          borderRadius: BorderRadius.circular(20)
        ),
        backgroundColor:CupertinoColors.black,
       context,
       screens: [
         HomePage(),
         HistoryPage(),
         ProfilePage()

      ],
        items: <PersistentBottomNavBarItem>[
          PersistentBottomNavBarItem(

              activeColorPrimary: Colors.grey,
              inactiveColorPrimary: Colors.white,

              title: 'Home',
              icon: Icon(Icons.home_outlined)),
          PersistentBottomNavBarItem(
              activeColorPrimary: Colors.grey,
              inactiveColorPrimary: Colors.white,

              title: 'History',
              icon: Icon(Icons.history_outlined)),
          PersistentBottomNavBarItem(
              activeColorPrimary: Colors.grey,
              inactiveColorPrimary: Colors.white,
              title: 'Profile',
              icon: Icon(Icons.account_circle_outlined)),

        ],
      ),

    );
  }

}
