

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LIFEX/LifeXScreen.dart';
import 'block_hub_home.dart';
import 'home.dart';

class MainScreen extends StatelessWidget {
  final int selectedIndex;

  const MainScreen({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'AI'),
        BottomNavigationBarItem(icon: Icon(Icons.view_in_ar), label: 'BlockHub'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'LifeX'),
        BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index == selectedIndex) return;
        switch (index) {
          case 0:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WalletScreen()));
            break;
          case 1:

            break;
          case 2:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BlockHubScreen()));
            break;
          case 3:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LifeXScreen()));

            break;
          case 4:

            break;
          case 5:
          // Settings: do nothing or implement as needed
            break;


            break;
        }
      },
    );
  }
}