import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:last_fm_app/src/app/last_fm_app.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(LastFMApp());
}
