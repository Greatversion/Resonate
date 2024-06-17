import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:resonate/main.dart';
import 'package:resonate/utils/clay_button.dart';
import 'package:resonate/view/addToPlaylist.dart';
import 'package:resonate/view/audio_player.dart';
import 'package:resonate/view/playlist.dart';
import 'package:resonate/view/roomScreen.dart';
import 'package:resonate/view/widgets/others.dart';
import 'package:resonate/view/widgets/source_dropdown.dart';
import 'widgets/source_players.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
   final OnAudioQuery _audioQuery = OnAudioQuery();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return  NewSongsTab(audioQuery: _audioQuery,);
          }));
        },
        child: Image.network(
            'https://cdn-icons-png.freepik.com/512/1382/1382065.png'),
      ),
      backgroundColor: darkColor.black,
      appBar: AppBar(
        toolbarHeight: 68,
        iconTheme: const IconThemeData(color: Colors.white, size: 25),
        backgroundColor: darkColor.darkgreen,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resonate',
              style: GoogleFonts.kanit(
                fontSize: 27,
                color: Colors.white,
              ),
            ),
            Text(
              'Sync with Peers',
              style: GoogleFonts.kanit(
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.wifi_tethering)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.wifi_protected_setup_sharp)),
        ],
      ),
      drawer: Drawer(
        backgroundColor: darkColor.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: darkColor.darkgreen,
              ),
              child: const Text('Menu'),
            ),
            ListTile(
              title: const Text(
                'Settings',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Navigate to settings
              },
            ),
            ListTile(
              title: const Text(
                'Help',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Navigate to help
              },
            ),
            ListTile(
              title: const Text(
                'About',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Navigate to about
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const RoomScreen();
                    }));
                  },
                  child: Center(
                    child: ButtonWidget(
                      text: 'Nearby Devices',
                    ),
                  )),
              HeaderText("Pairing Modes"),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: ModesWidget(),
              ),
              Divider(
                color: darkColor.lightgrey,
              ),
              HeaderText("Available Sources"),
              SourceWidget(),
              const SizedBox(
                height: 5,
              ),
              Divider(
                color: darkColor.lightgrey,
              ),
              HeaderText("Recent Devices"),
              const RecentDevice(),
              Divider(
                color: darkColor.lightgrey,
              ),
              HeaderText("Audio Library"),
              const AudioLibrary(),
              Divider(
                color: darkColor.lightgrey,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AudioPlayerWidget(),
    );
  }
}
