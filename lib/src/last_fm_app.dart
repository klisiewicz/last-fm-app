import 'package:flutter/material.dart';

class LastFMApp extends StatelessWidget {
  const LastFMApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Text('LastFM app'),
        ),
      ),
    );
  }
}
