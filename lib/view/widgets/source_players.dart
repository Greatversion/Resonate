import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:push_button/push_button.dart';
import 'package:resonate/view/playlist.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

class SourceWidget extends StatelessWidget {
  SourceWidget({super.key});
  final List<Widget> sourceDataList = [
    SourceColumn(
        'https://static.vecteezy.com/system/resources/previews/023/986/704/non_2x/youtube-logo-youtube-logo-transparent-youtube-icon-transparent-free-free-png.png',
        'Youtube'),
    SourceColumn(
        'https://www.freepnglogos.com/uploads/spotify-logo-png/spotify-logo-transparent-spotify-logo-images-25.png',
        'Spotify'),
    SourceColumn(
        'https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Media_Player_Windows_11_logo.svg/2048px-Media_Player_Windows_11_logo.svg.png',
        'Media Player'),
  ];
  Future<void> _launchUrl(String url, String fallbackUrl) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else if (await canLaunchUrl(Uri.parse(fallbackUrl))) {
      await launchUrl(Uri.parse(fallbackUrl));
    } else {
      throw 'Could not launch $url or $fallbackUrl';
    }
  }

  Future<void> openYouTube() async {
    const String url = 'youtube://www.youtube.com/';
    const String fallbackUrl = 'https://www.youtube.com/';
    await _launchUrl(url, fallbackUrl);
  }

  Future<void> openSpotify() async {
    const String url = 'spotify://';
    const String fallbackUrl = 'https://open.spotify.com/';
    await _launchUrl(url, fallbackUrl);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 5,
        crossAxisSpacing: 10,
        crossAxisCount: 3,
      ),
      itemBuilder: (BuildContext context, int index) {
        return PushButton(
          shadowColor: darkColor.lightgreen,
          shadowOffset: 2.5,
          strokeWidth: 1.3,
          backgroundColor: darkColor.lightgrey,
          buttonHeight: 100,
          buttonWidth: 110,
          onPressed: () {
            if (index == 0) {
              openYouTube();
            } else if (index == 1) {
              openSpotify();
            } else if (index == 2) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MediaLibraryScreen()),
              );
            }
          },
          child: sourceDataList[index],
        );
      },
      itemCount: sourceDataList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}

// ignore: non_constant_identifier_names
Widget SourceColumn(String url, String text) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CachedNetworkImage(
        key: UniqueKey(),
        imageUrl: url,
        height: 50,
        width: 100,
        maxHeightDiskCache: 200,
        fit: BoxFit.fitHeight,
      ),
      Text(
        text,
        style: const TextStyle(
          color: Color.fromARGB(244, 255, 255, 255),
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
