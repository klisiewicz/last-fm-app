import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:last_fm_app/src/track/view/tracks_page.dart';

class LastFMApp extends StatelessWidget {
  const LastFMApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          accentColor: const Color(0xFFB90404),
          primaryColor: const Color(0xFF140404),
        ),
        home: const TracksPage(),
      ),
    );
  }
}
