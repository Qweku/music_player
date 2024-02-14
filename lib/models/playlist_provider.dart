import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
        songName: "Konongo Zongo",
        artistName: "Black Sheriff",
        albumArtImagePath: "assets/images/album_cover.jpg",
        audioPath: "audio/black_sherif.mp3"),
    Song(
        songName: "Bandana",
        artistName: "Fireboy ft Asake",
        albumArtImagePath: "assets/images/album_cover_1.png",
        audioPath: "audio/fireboy.mp3")
  ];

  //current song playing
  int? _currentSongIndex;

  // A U D I O  P L A Y E R

  //audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  // duration
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // constructor
  PlaylistProvider() {
    listenToDuration();
  }

  // initially not playing
  bool _isPlaying = false;

  // play the song
  void play() async {
    final String path = _playlist[currentSongIndex!].audioPath;
    await _audioPlayer.stop(); // stop current song
    await _audioPlayer.play(AssetSource(path)); // play new song
    _isPlaying = true;
    notifyListeners();
  }

  // pause current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }

    notifyListeners();
  }

  // seek to a specific position in the current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
    notifyListeners();
  }

  // play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        // increase by one
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        //back to the first song
        currentSongIndex = 0;
      }
    }
  }

  // play previous song
  void playPreviousSong() async {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  // listen to duration
  void listenToDuration() {
    // listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    // listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    // listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play();
    }

    notifyListeners();
  }
}
