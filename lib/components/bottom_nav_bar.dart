import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: Colors.blueGrey,
      items: [
        BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'homePage');
                },
                icon: const Icon(Icons.home)),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'discoverPage');
                },
                icon: const Icon(Icons.search)),
            label: 'Search'),
        BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'profilePage');
                },
                icon: const Icon(Icons.person)),
            label: 'Profile'),
      ],
    );
  }
}
