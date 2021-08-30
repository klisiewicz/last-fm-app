import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:last_fm_app/src/app/app_router.dart';

class LastFMApp extends StatelessWidget {
  final _appRouter = AppRouter();

  LastFMApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xFFB90404);
    return ProviderScope(
      child: MaterialApp.router(
        title: 'LastFM',
        theme: ThemeData(
          accentColor: accentColor,
          brightness: Brightness.dark,
          primaryColor: const Color(0xFF140404),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: accentColor,
          ),
        ),
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}
