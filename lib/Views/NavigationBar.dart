import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'MyTrips.dart';
import 'NotificationsPage.dart';
import 'ProfilePage.dart';
import 'TopDriver.dart';
import 'home_page.dart';

class NavigationBarPage extends StatefulWidget {
  NavigationBarPage({Key? key}) : super(key: key);

  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  int _bottomNavBarIndex = 0;

  // Create Pages
  List<Widget> pages = [
    HomePagea(),
    MyTripsPage(),
    NotificationsPage(),
    DriversPage(),
    ProfilePage()
  ];

// Create Icons for Pages
  List<IconData> pagesIcons = [
    Icons.home,
    Icons.car_repair,
    Icons.notifications,
    Icons.emoji_events,
    Icons.person
  ];

  // Create Titles for Pages
  List<String> pagesTitles = [
    'Home',
    'My Trips',
    'Notifications',
    'Drivers',
    'My Profile'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              pagesTitles[_bottomNavBarIndex],
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: IndexedStack(
        index: _bottomNavBarIndex,
        children: pages,
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        activeIndex: _bottomNavBarIndex,
        splashColor: Colors.redAccent,
        activeColor: Colors.green,
        icons: pagesIcons,
        onTap: (index) {
          setState(() {
            _bottomNavBarIndex = index;
          });
        },
        gapLocation: GapLocation.none,
      ),
    );
  }
}
