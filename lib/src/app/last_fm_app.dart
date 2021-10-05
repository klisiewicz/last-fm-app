import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:last_fm_app/src/app/app_router.dart';

class LastFMApp extends StatelessWidget {
  final _appRouter = AppRouter();

  LastFMApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xFFB90404);
    final theme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF140404),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: accentColor,
      ),
    );
    return ProviderScope(
      child: MaterialApp.router(
        title: 'LastFM',
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(secondary: accentColor),
        ),
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}
