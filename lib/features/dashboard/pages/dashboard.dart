
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
    var drawermargin = MediaQuery.of(context).size.height*0.07;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: Column(
          children: [
            SizedBox(height: 70,),
            AppBar(
              title: Center(child: Text("Dashboard")),
              actions: [
                Container(
                    padding:EdgeInsets.all(20),
            child: Icon(CupertinoIcons.bell,color: Colors.white,size: 30,))
              ],
              // leading: Icon(CupertinoIcons.list_bullet_indent,)
            ),
          ],
        ),
      ),
      drawer: Container(
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(50)
        // ),
        margin: EdgeInsets.fromLTRB(0, 140, 0, 20),

        child: Drawer(
          shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        // borderRadius: BorderRadius.only(
        // topRight: Radius.circular(20),
        //   bottomRight: Radius.circular(20)),
    ),

            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                 DrawerHeader(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)          ,
                    color: Colors.black,
                  ),
                  child: Text(
                    'Navigation Drawer',
                    style: TextStyle(fontSize: 20,color: Colors.white),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: const Text(' My Profile '),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.book),
                  title: const Text(' My Course '),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.workspace_premium),
                  title: const Text(' Go Premium '),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.video_label),
                  title: const Text(' Saved Videos '),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: const Text(' Edit Profile '),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: const Text('LogOut'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],

          ),
        ),
      ),



      body:PersistentTabView(

        margin: EdgeInsets.fromLTRB(20, 20, 20, 50),
        decoration:NavBarDecoration(

          borderRadius: BorderRadius.circular(30)
        ),
        backgroundColor:CupertinoColors.white,
       context,
       screens: [
         HomePage(),
         HistoryPage(),
         ProfilePage()

      ],
        items: <PersistentBottomNavBarItem>[
          PersistentBottomNavBarItem(

              activeColorPrimary: Colors.grey,
              inactiveColorPrimary: Colors.black,

              title: 'Home',
              icon: Icon(Icons.home_outlined)),
          PersistentBottomNavBarItem(
              activeColorPrimary: Colors.grey,
              inactiveColorPrimary: Colors.black,

              title: 'History',
              icon: Icon(Icons.history_outlined)),

          PersistentBottomNavBarItem(
              activeColorPrimary: Colors.grey,
              inactiveColorPrimary: Colors.black,
              title: 'Profile',
              icon: Icon(Icons.account_circle_outlined)),

        ],
      ),

    );
  }

}
