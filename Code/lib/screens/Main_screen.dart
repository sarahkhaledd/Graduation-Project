import 'package:flutter/material.dart';
import 'package:kherwallet/screens/CategoryList_screen.dart';
import 'package:kherwallet/screens/Home.dart';
import 'package:kherwallet/screens/Requests_screen.dart';
import 'Help_screen.dart';
import 'Notifications_screen.dart';

class Main_screen extends StatefulWidget {
  const Main_screen({Key? key}) : super(key: key);

  @override
  State<Main_screen> createState() => _Main_screenState();
}

class _Main_screenState extends State<Main_screen> {
  @override

  int _selectedIndex = 2;
  static const List<Widget> _widgetOptions = <Widget>[
    CategoryList(),
    Requests_screen(),
    Home(),
    Notifications_screen(),
    HelpScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7fffb),
      //search icon & user icon
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
                Icons.list,
                color: Colors.grey),
            label: 'Category Lists',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.receipt,
                color: Colors.grey),
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.home,
                color: Colors.grey),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.notifications_active_outlined,
                color: Colors.grey),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.help_outline_outlined,
                color: Colors.grey),
            label: 'Help',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xffff66624),
        onTap: _onItemTapped,
      ),
    );
  }
}
