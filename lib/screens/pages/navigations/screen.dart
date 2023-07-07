import 'package:flutter/material.dart';
import 'package:insight_app/screens/pages/navigations/home.dart';
import 'package:insight_app/screens/pages/navigations/inbox.dart';
import 'package:insight_app/screens/pages/navigations/search.dart';
import 'package:insight_app/screens/pages/navigations/space.dart';
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
        child: Space(),
      ),
      Center(
        child: Notify(),
      ),
      Center(
        child: Inbox(),
      )
    ];

    return Scaffold(
        body: Center(
          child: tabs.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, spreadRadius: 0, blurRadius: 20),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(0.0)),
              child: BottomNavigationBar(
                //  type: BottomNavigationBarType.shifting,
                unselectedItemColor: Colors.black54,
                backgroundColor: Colors.white,
                elevation: 10,
                iconSize: 10,

                selectedIconTheme:
                    const IconThemeData(color: Color(0xff04172B), size: 15),
                selectedItemColor: const Color(0xFF11101E),
                mouseCursor: SystemMouseCursors.grab,
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.w600),
                unselectedIconTheme: const IconThemeData(
                  color: Colors.black54,
                ),
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.share_location_sharp),
                    label: 'Location',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.message_outlined),
                    label: 'Messages',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
                  ),
                ],
                currentIndex: _selectedIndex, //New
                onTap: _onItemTapped,
              ),
            )));
  }
}
