import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:last_fm_app/src/track/view/tracks_page.dart';

class LastFMApp extends StatelessWidget {
  const LastFMApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xFFB90404);
    return ProviderScope(
      child: MaterialApp(
        title: 'LastFM',
        theme: ThemeData(
          accentColor: accentColor,
          brightness: Brightness.dark,
          primaryColor: const Color(0xFF140404),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: accentColor,
          ),
        ),
        home: const TracksPage(),
      ),
    );
  }
}
