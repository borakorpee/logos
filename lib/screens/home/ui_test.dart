import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logos/screens/home/favorites_page.dart';
import 'package:logos/screens/home/history_page.dart';
import 'package:logos/screens/home/home_page.dart';

class UiTest extends StatefulWidget {
  const UiTest({super.key});

  @override
  State<UiTest> createState() => _UiTestState();
}

class _UiTestState extends State<UiTest> {
  int _selectedIndex = 0;

  List pages = [
    HomePage(),
    HistoryPage(),
    FavoritesPage(),
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

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 0.7,
              color: Colors.black.withOpacity(0.25),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 0.7,
              color: Colors.black.withOpacity(0.25),
            ),
          ),
          hintText: "Psikiyatri Doktoru Ara...",
          hintStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: IconButton(
            onPressed: null,
            icon: SvgPicture.asset("assets/home/search.svg"),
            iconSize: 20,
          ),
        ),
      ),
    );
  }
}

class Appbar extends StatelessWidget {
  const Appbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/login/headlogo.png",
                width: 50,
                height: 50,
              ),
              const Text("LOGOS")
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/home/people.svg",
            ),
            iconSize: 40,
          )
        ],
      ),
    );
  }
}
