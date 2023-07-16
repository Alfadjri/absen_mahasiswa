import 'package:absensi_siswa/constants/color.dart';
import 'package:absensi_siswa/view/absense/absense.dart';
import 'package:flutter/material.dart';
import 'package:absensi_siswa/view/absense/home.dart';
import 'package:absensi_siswa/view/absense/profile.dart';

class Navbar_bottom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyNavbarState();
  }
}

class _MyNavbarState extends State<Navbar_bottom>{
  int _selectedIndex = 0;
  List<NavigationItem> _navigationItems = [
    NavigationItem(
      title: 'Home',
      icon: Icons.home,
      pageBuilder: () => Home(),
    ),
    NavigationItem(
      title: 'Absense',
      icon: Icons.calendar_month_outlined,
      pageBuilder: () => Absense(),
    ),
    NavigationItem(
      title: 'Profile',
      icon: Icons.person,
      pageBuilder: () => Profile(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = _navigationItems
        .map((item) => BottomNavigationBarItem(
              icon: Icon(item.icon),
              label: item.title,
            ))
        .toList();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _navigationItems[_selectedIndex].pageBuilder(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: items,
          selectedItemColor: appOrange,
        ),
      ),
    );
  }
}

class NavigationItem {
  final String title;
  final IconData icon;
  final Widget Function() pageBuilder;

  NavigationItem({
    required this.title,
    required this.icon,
    required this.pageBuilder,
  });
}

