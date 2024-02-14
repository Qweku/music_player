import 'package:flutter/material.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:music_player/screens/home_screen.dart';
import 'package:music_player/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=>ThemeProvider()),
    ChangeNotifierProvider(create: (context)=>PlaylistProvider())
  ],
  child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Player',
      theme: context.watch<ThemeProvider>().themeData,
      home: const HomeScreen(),
    );
  }
}

