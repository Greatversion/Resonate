import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resonate/main.dart';

class MediaLibraryScreen extends StatefulWidget {
  const MediaLibraryScreen({super.key});

  @override
  _MediaLibraryScreenState createState() => _MediaLibraryScreenState();
}

class _MediaLibraryScreenState extends State<MediaLibraryScreen>
    with SingleTickerProviderStateMixin {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  bool _permissionsGranted = false;
  late TabController _tabController;
  //  ExpandedAudioPlayer audioPlayer =ExpandedAudioPlayer();
  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _tabController = TabController(length: 4, vsync: this);
  }

  Future<void> _requestPermissions() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      setState(() {
        _permissionsGranted = true;
      });
    } else {
      // Handle permission denial
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_permissionsGranted) {
      return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: darkColor.darkgreen,
          title: Text(
            'Media Library',
            style: GoogleFonts.kanit(
              // fontSize: 27,
              color: Colors.white,
            ),
          ),
        ),
        body: const Center(
          child: Text('Permissions not granted'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: darkColor.darkgreen,
        title: Text(
          'Media Library',
          style: GoogleFonts.kanit(
            // fontSize: 27,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_vert_outlined))
        ],
        bottom: TabBar(
          labelStyle: GoogleFonts.kanit(
            color: Colors.white,
          ),
          unselectedLabelStyle: GoogleFonts.kanit(
            color: const Color.fromARGB(188, 195, 194, 194),
          ),
          indicatorColor: Colors.white,
          dividerColor: darkColor.black,
          controller: _tabController,
          tabs: const [
            Tab(text: 'Songs'),
            Tab(text: 'Albums'),
            Tab(text: 'Artists'),
            Tab(text: 'Playlists'),
          ],
        ),
      ),
      body: Container(
        color: darkColor.black,
        child: TabBarView(
          controller: _tabController,
          children: [
            SongsTab(audioQuery: _audioQuery),
            AlbumsTab(audioQuery: _audioQuery),
            ArtistsTab(audioQuery: _audioQuery),
            PlaylistsTab(audioQuery: _audioQuery),
          ],
        ),
      ),
    );
  }
}

class SongsTab extends StatelessWidget {
  final OnAudioQuery audioQuery;

  const SongsTab({super.key, required this.audioQuery});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      future: audioQuery.querySongs(
        sortType: SongSortType.DATE_ADDED,
        orderType: OrderType.DESC_OR_GREATER,
        uriType: UriType.EXTERNAL,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: darkColor.darkgreen,
          ));
        } else if (snapshot.hasError) {
          return Center(
              child: Text(
            'Error: ${snapshot.error}',
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text(
            'No songs found',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ));
        }

        var songs = snapshot.data!;
        return ListView.builder(
          itemCount: songs.length,
          itemBuilder: (context, index) {
            var song = songs[index];
            return ListTile(
              leading: const Icon(
                Icons.music_note,
                color: Colors.blueAccent,
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
            );
          },
        );
      },
    );
  }
}

class AlbumsTab extends StatelessWidget {
  final OnAudioQuery audioQuery;

  const AlbumsTab({super.key, required this.audioQuery});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AlbumModel>>(
      future: audioQuery.queryAlbums(
        sortType: AlbumSortType.ALBUM,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: darkColor.darkgreen,
          ));
        } else if (snapshot.hasError) {
          return Center(
              child: Text(
            'Error: ${snapshot.error}',
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text(
            'No albums found',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ));
        }

        var albums = snapshot.data!;
        return ListView.builder(
          itemCount: albums.length,
          itemBuilder: (context, index) {
            var album = albums[index];
            return ListTile(
              leading: const Icon(
                Icons.album,
                color: Colors.blueAccent,
              ),
              title: Text(
                album.album,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              subtitle: Text(
                album.artist ?? 'Unknown artist',
                style: const TextStyle(
                    color: Color.fromARGB(255, 119, 119, 119), fontSize: 13),
              ),
            );
          },
        );
      },
    );
  }
}

class ArtistsTab extends StatelessWidget {
  final OnAudioQuery audioQuery;

  const ArtistsTab({super.key, required this.audioQuery});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArtistModel>>(
      future: audioQuery.queryArtists(
        sortType: ArtistSortType.ARTIST,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: darkColor.darkgreen,
          ));
        } else if (snapshot.hasError) {
          return Center(
              child: Text(
            'Error: ${snapshot.error}',
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text(
            'No artists found',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ));
        }

        var artists = snapshot.data!;
        return ListView.builder(
          itemCount: artists.length,
          itemBuilder: (context, index) {
            var artist = artists[index];
            return ListTile(
              splashColor: Colors.white,
              leading: const Icon(
                Icons.person,
                color: Colors.blueAccent,
              ),
              title: Text(
                artist.artist,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              subtitle: Text(
                '${artist.numberOfAlbums} albums',
                style: const TextStyle(
                    color: Color.fromARGB(255, 119, 119, 119), fontSize: 13),
              ),
            );
          },
        );
      },
    );
  }
}

class PlaylistsTab extends StatelessWidget {
  final OnAudioQuery audioQuery;

  const PlaylistsTab({super.key, required this.audioQuery});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PlaylistModel>>(
      future: audioQuery.queryPlaylists(
        sortType: PlaylistSortType.PLAYLIST,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: darkColor.darkgreen,
          ));
        } else if (snapshot.hasError) {
          return Center(
              child: Text(
            'Error: ${snapshot.error}',
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text(
            'No playlists found',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ));
        }

        var playlists = snapshot.data!;
        return ListView.builder(
          itemCount: playlists.length,
          itemBuilder: (context, index) {
            var playlist = playlists[index];
            return ListTile(
              splashColor: darkColor.darkgreen,
              leading: const Icon(
                Icons.playlist_play,
                color: Colors.blueAccent,
              ),
              title: Text(
                playlist.playlist,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              subtitle: Text(
                '${playlist.numOfSongs} songs',
                style: const TextStyle(
                    color: Color.fromARGB(255, 119, 119, 119), fontSize: 13),
              ),
            );
          },
        );
      },
    );
  }
}


