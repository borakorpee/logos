import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logos/screens/home/favorites_page.dart';
import 'package:logos/screens/home/history_page.dart';
import 'package:logos/screens/home/home_page.dart';

class BottomNavbar extends StatefulWidget {
  static const routeName = "/ui-test";
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;

  List pages = [
    const HomePage(),
    const HistoryPage(),
    const FavoritesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset("assets/home/home_filled.svg"),
            icon: SvgPicture.asset("assets/home/home.svg"),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset("assets/home/history_filled.svg"),
            icon: SvgPicture.asset("assets/home/history.svg"),
            label: 'Geçmiş',
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset("assets/home/bookmarked_filled.svg"),
            icon: SvgPicture.asset("assets/home/bookmarked.svg"),
            label: 'Kaydedilenler',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
