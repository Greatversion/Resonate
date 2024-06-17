import 'package:flutter/material.dart';
import 'package:resonate/main.dart';

class AudioLibrary extends StatelessWidget {
  const AudioLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: ListTile(
            tileColor: darkColor.lightgrey,
            leading: const Icon(Icons.music_note),
            title: const Text(
              'Track 1',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: const Text(
              'Created by : Ashish',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        ListTile(
          tileColor: darkColor.lightgrey,
          leading: const Icon(Icons.music_note),
          title: const Text(
            'Track 2',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: const Text(
            'Created by : Arjit',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class RecentDevice extends StatelessWidget {
  const RecentDevice({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: ListTile(
            tileColor: darkColor.lightgrey,
            leading: const Icon(Icons.devices),
            title: const Text(
              'Device 1',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: const Text(
              'Synchronized',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        ListTile(
          tileColor: darkColor.lightgrey,
          leading: const Icon(Icons.devices),
          title: const Text(
            'Device 1',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: const Text(
            'Synchronized',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

Widget HeaderText(String text) {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: Text(
      text,
      style: const TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}

class RotatingImage extends StatefulWidget {
  final String imageUrl;

  const RotatingImage({super.key, required this.imageUrl});

  @override
  // ignore: library_private_types_in_public_api
  _RotatingImageState createState() => _RotatingImageState();
}

class _RotatingImageState extends State<RotatingImage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      child: Image.network(
        widget.imageUrl,
        width: 200,
        height: 200,
      ),
    );
  }
}