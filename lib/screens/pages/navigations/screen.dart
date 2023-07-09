import 'package:flutter/material.dart';
import 'package:insight_app/screens/pages/navigations/home.dart';
import 'package:insight_app/screens/pages/navigations/profile.dart';
import 'package:insight_app/screens/pages/navigations/search.dart';
import 'package:insight_app/screens/pages/navigations/insight.dart';
import 'package:insight_app/screens/pages/navigations/notification.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int _selectedIndex = 0;

  void _selectedPage(int index) {
    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      Center(
        child: HomePage(),
      ),
      Center(child: Search()),
      Center(
        child: Insight(),
      ),
      Center(
        child: Notify(),
      ),
      Center(
        child: Profile(),
      )
    ];

    return Scaffold(
        body: Center(
          child: tabs.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, spreadRadius: 0, blurRadius: 20),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(0.0)),
              child: Container(
                color: Colors.orange,
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.shifting,
                  elevation: 10,
                  iconSize: 10,

                  selectedIconTheme: const IconThemeData(
                      color: Color.fromARGB(255, 43, 4, 4), size: 15),
                  selectedItemColor: const Color(0xFF11101E),
                  mouseCursor: SystemMouseCursors.grab,
                  selectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 10),
                  unselectedIconTheme: const IconThemeData(
                    color: Colors.black54,
                  ),
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: 'Discover',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.file_present_sharp),
                      label: 'Add',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.notifications_none),
                      label: 'Alerts',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_4_outlined),
                      label: 'Profile',
                    ),
                  ],
                  currentIndex: _selectedIndex, //New
                  onTap: _onItemTapped,
                ),
              ),
            )));
  }
}
