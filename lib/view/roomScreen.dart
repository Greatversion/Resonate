// ignore: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resonate/view/widgets/ripple_effect.dart';

import '../main.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white, size: 25),
        backgroundColor: darkColor.darkgreen,
        title: Text(
          'Searching for new devices',
          style: GoogleFonts.kanit(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_vert_outlined))
        ],
      ),
      backgroundColor: darkColor.black,
      body: const Center(child: RippleWidget()),
    );
  }
}
