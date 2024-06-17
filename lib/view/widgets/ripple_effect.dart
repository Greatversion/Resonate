import 'dart:math';
import 'package:flutter/material.dart';
import 'package:resonate/main.dart';
import 'package:resonate/utils/clay_button.dart';
import 'package:ripple_wave/ripple_wave.dart';

class RippleEffect extends StatefulWidget {
  const RippleEffect({super.key});

  @override
  _RippleEffectState createState() => _RippleEffectState();
}

class _RippleEffectState extends State<RippleEffect> {
  // ignore: non_constant_identifier_names
  bool _Searching = false;

  final List<String> participants = [
    'A',
  ]; // Placeholder for participant avatars

  void _toggleRippleEffect() {
    setState(() {
      _Searching = !_Searching;
    });
  }

  Widget _buildAvatar(String participant) {
    return CircleAvatar(
      radius: 20,
      child: Text(participant),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.36,
        child: Stack(
          children: [
            GestureDetector(
                onTap: _toggleRippleEffect,
                child: _Searching
                    ? const RippleWidget()
                    : Center(
                        child: ButtonWidget(
                        text: "Nearby Devices",
                      ))),
          ],
        ),
      ),
    );
  }
}

class RippleWidget extends StatefulWidget {
  const RippleWidget({super.key});

  @override
  State<RippleWidget> createState() => _RippleWidgetState();
}

class _RippleWidgetState extends State<RippleWidget> {
  bool _Searching = false;

  final List<String> participants = [
    'A',
  ];
  // Placeholder for participant avatars
  void _toggleRippleEffect() {
    setState(() {
      _Searching = !_Searching;
    });
  }

  Widget _buildAvatar(String participant) {
    return CircleAvatar(
      radius: 20,
      child: Text(participant),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.36,
      child: Stack(
        children: [
          RippleWave(
            waveCount: 10,
            color: darkColor.darkgreen,
            childTween: Tween(begin: 0.5, end: 1.0),
            duration: const Duration(seconds: 1),
            child: ButtonWidget(text: "Searching"),
          ),
          ...participants.map((participant) {
            final double angle =
                360 / participants.length * participants.indexOf(participant);
            final double radians = angle * (3.14 / 180);
            const double distance = 100.0;

            return Positioned(
              left: 75 + distance * cos(radians),
              top: 75 + distance * sin(radians),
              child: _buildAvatar(participant),
            );
          }).toList(),
        ],
      ),
    );
  }
}
