import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resonate/main.dart';
import 'package:resonate/view/widgets/others.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          useSafeArea: true,
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return ExpandedAudioPlayer(
              isPlaying: _isPlaying,
              onPlayPause: () {
                setState(() {
                  _isPlaying = !_isPlaying;
                });
              },
              onNext: () {
                // Handle skip to next
              },
            );
          },
        );
      },
      child: Container(
        height: 60,
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://img.freepik.com/premium-vector/white-music-icon-round-isolated-button-vector-illustration_541075-1027.jpg"),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No Song Selected"),
              ],
            ),
            IconButton(
              icon: _isPlaying
                  ? const Icon(Icons.pause)
                  : const Icon(Icons.play_arrow),
              onPressed: () {
                setState(() {
                  _isPlaying = !_isPlaying;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.skip_next),
              onPressed: () {
                // Handle skip to next
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ExpandedAudioPlayer extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback onNext;

  const ExpandedAudioPlayer({
    super.key,
    required this.isPlaying,
    required this.onPlayPause,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: darkColor.darkgreen,
          title: Text(
            "Media Player",
            style: GoogleFonts.kanit(
              // fontSize: 27,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          color: darkColor.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const RotatingImage(
                  imageUrl:
                      'https://cdn-icons-png.freepik.com/512/1382/1382065.png'),
              const Text(
                'Song Title',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Artist Name',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.skip_previous),
                    onPressed: () {
                      // Handle skip to previous
                    },
                  ),
                  IconButton(
                    icon: isPlaying
                        ? const Icon(Icons.pause)
                        : const Icon(Icons.play_arrow),
                    onPressed: onPlayPause,
                  ),
                  IconButton(
                    icon: const Icon(Icons.skip_next),
                    onPressed: onNext,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
