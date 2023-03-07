
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../../bookings/bookings_page.dart';
import '../../home/pages/home.dart';
import '../../home/pages/new_home.dart';
import '../../notifications/pages/notification_page.dart';
import '../../profile/pages/profile.dart';
import '../../wallet/pages/wallet_page.dart';


class DashboardPage extends StatefulWidget {

   DashboardPage({Key? key, }) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body:  IndexedStack(
          children: [
            BookingsPage(),
            HomePage(),
            WalletPage(),
            NotificationPage(),
            ProfilePage()
          ],
          index: _currentIndex,
        ),

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items:  [
          BottomNavigationBarItem(
              icon: FaIcon(
                CupertinoIcons.book,
                // FontAwesomeIcons.book,
                color: Colors.black,
              ),
              label: "Bookings"),
          BottomNavigationBarItem(
              icon: FaIcon(
                CupertinoIcons.car_detailed,
                color: Colors.black,
              ),
              label:  "Home"),
          BottomNavigationBarItem(
              icon: FaIcon(
                Icons.wallet,
                color: Colors.black,
              ),
              label: "Wallet"),
          BottomNavigationBarItem(
              icon: FaIcon(
                Icons.notifications,
                color: Colors.black,
              ),
              label: "Notification"),
          BottomNavigationBarItem(
              icon: FaIcon(
                CupertinoIcons.settings_solid,
                // FontAwesomeIcons.,
                color: Colors.black,
              ),
              label: "Profile"),

        ],
      ),
    ));
  }
}
