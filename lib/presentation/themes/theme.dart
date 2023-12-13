import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color.fromARGB(255, 118, 26, 141);
  static const Color secondaryColor = Colors.deepPurple;
  static const Color thirdColor = Colors.white;
  static const Color forthColor = Color.fromARGB(255, 26, 126, 208);
}
class AppGradients {
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Colors.blue, Colors.purple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}