import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resonate/view/dashboardScreen.dart';
// import 'package:resonate/view/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>  DashBoardScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                "Resonate 🎵",
                textStyle: GoogleFonts.orbitron(
                    textStyle:
                        const TextStyle(fontSize: 30, color: Colors.white)),
                speed: const Duration(milliseconds: 150),
              ),
            ],
            totalRepeatCount: 4,
          ), // Replace with your GIF path
        ),
      ),
    );
  }
}
