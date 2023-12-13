import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/presentation/screens/Animated_Screen.dart';
import 'package:flutter_application_firebase/presentation/screens/QR_Screen.dart';
import 'package:flutter_application_firebase/presentation/screens/Shop_screen.dart';
import 'package:flutter_application_firebase/presentation/screens/User_Screen.dart';
import 'package:flutter_application_firebase/presentation/themes/theme.dart';


class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    InstrumentsListScreen(),
    QrScannerScreen(),
    Anima(),
    UserPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: AppColors.primaryColor,
        activeColor: AppColors.thirdColor,
        items: [
          TabItem(icon: Icons.shop, title: 'Shop'),
          TabItem(icon: Icons.qr_code, title: 'QR'),
          TabItem(icon: Icons.animation, title: 'Profile'),
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




