import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:last_fm_app/src/last_fm_app.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const LastFMApp());
}
