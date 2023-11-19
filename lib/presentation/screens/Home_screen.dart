
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/presentation/screens/Animated_Screen.dart';
import 'package:flutter_application_firebase/presentation/screens/QR_Screen.dart';
import 'package:flutter_application_firebase/presentation/screens/Shop_screen.dart';
import 'package:flutter_application_firebase/presentation/screens/User_Screen.dart';





class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    InstrumentsListScreen(),
    QrScannerScreen(),
    UserPage(),
    Anima()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.purple,
        activeColor: Colors.black,
        items: [
          TabItem(icon: Icons.home, title: 'Shop'),
          TabItem(icon: Icons.search, title: 'QR'),
          TabItem(icon: Icons.person, title: 'Profile'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        initialActiveIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}




