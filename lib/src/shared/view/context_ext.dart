import 'package:flutter/material.dart';

extension BuildContextThemeExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  void hideKeyboard() => FocusScope.of(this).unfocus();
}
