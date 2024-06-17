import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resonate/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistScreen extends StatefulWidget {
  final List<SongModel> selectedSongs;

  const PlaylistScreen({super.key, required this.selectedSongs});

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final TextEditingController _playlistNameController = TextEditingController();

  Future<void> _savePlaylist() async {
    String playlistName = _playlistNameController.text;
    if (playlistName.isEmpty) {
      // Show an error if the playlist name is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a playlist name')),
      );
      return;
    }

    List<String> songIds = widget.selectedSongs.map((song) => song.id.toString()).toList();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(playlistName, songIds);

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Playlist "$playlistName" saved')),
    );

    // Clear the text field and pop the screen
    _playlistNameController.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: darkColor.darkgreen,
        title: Text(
          'Create Playlist',
          style: GoogleFonts.kanit(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _playlistNameController,
              decoration: InputDecoration(
                labelText: 'Playlist Name',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _savePlaylist,
              child: Text('Save Playlist'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.selectedSongs.length,
                itemBuilder: (context, index) {
                  var song = widget.selectedSongs[index];
                  return ListTile(
                    leading: Icon(
                      Icons.music_note,
                      color: Colors.blueAccent,
                    ),
                    title: Text(
                      song.title,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    subtitle: Text(
                      song.artist ?? 'Unknown artist',
                      style: TextStyle(
                          color: Color.fromARGB(255, 119, 119, 119), fontSize: 13),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewSongsTab extends StatefulWidget {
  final OnAudioQuery audioQuery;

  const NewSongsTab({super.key, required this.audioQuery});

  @override
  _NewSongsTabState createState() => _NewSongsTabState();
}

class _NewSongsTabState extends State<NewSongsTab> {
  List<SongModel> _selectedSongs = [];

  void _toggleSelection(SongModel song) {
    setState(() {
      if (_selectedSongs.contains(song)) {
        _selectedSongs.remove(song);
      } else {
        _selectedSongs.add(song);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      future: widget.audioQuery.querySongs(
        sortType: SongSortType.DATE_ADDED,
        orderType: OrderType.DESC_OR_GREATER,
        uriType: UriType.EXTERNAL,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: darkColor.darkgreen,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'No songs found',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          );
        }

        var songs = snapshot.data!;
        return Material(
          child: Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: darkColor.darkgreen,
              title: Text(
                'Media Library',
                style: GoogleFonts.kanit(
                  color: Colors.white,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.playlist_add),
                  onPressed: () {
                    if (_selectedSongs.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaylistScreen(selectedSongs: _selectedSongs),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Select at least one song to create a playlist')),
                      );
                    }
                  },
                ),
              ],
            ),
            body: Container(
              color: darkColor.black,
              child: ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  var song = songs[index];
                  bool isSelected = _selectedSongs.contains(song);
                  return GestureDetector(
                    onTap: () => _toggleSelection(song),
                    child: ListTile(
                      leading: Icon(
                        isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                        color: isSelected ? Colors.green : Colors.blueAccent,
                      ),
                      title: Text(
                        song.title,
                        style: const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      subtitle: Text(
                        song.artist ?? 'Unknown artist',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 119, 119, 119), fontSize: 13),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
