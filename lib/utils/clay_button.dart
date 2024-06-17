
// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:resonate/main.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  String text;
  ButtonWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xff100e11),
          boxShadow: [
            BoxShadow(
                color: darkColor.darkgreen,
                offset: const Offset(-8, -5),
                blurRadius: 10),
            BoxShadow(
                color: darkColor.darkgreen,
                offset: const Offset(8, 5),
                blurRadius: 10)
          ]),
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: darkColor.darkgreen),
        padding: const EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.black, darkColor.lightgrey])),
          child: ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) => const RadialGradient(
              center: Alignment.topCenter,
              stops: [.2, 1],
              colors: [Colors.white, Colors.grey],
            ).createShader(bounds),
            child: Center(
              child: Text(
                text,
                style:
                    const TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
