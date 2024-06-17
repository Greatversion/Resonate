import 'package:flutter/material.dart';
import 'package:resonate/utils/color.dart';


import 'package:resonate/view/splashScreen.dart';
// ignore: library_prefixes

DarkAppColorPallete darkColor = DarkAppColorPallete();
void main() {
  runApp(const Resonate());
}

class Resonate extends StatelessWidget {
  const Resonate({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}
