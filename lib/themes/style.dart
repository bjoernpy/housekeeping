import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.white,
    fontFamily: "Quicksand",
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: Colors.black,
      secondary: Colors.white,
      error: Colors.red[400],
    ),
    hintColor: Colors.grey[200],
    iconTheme: IconThemeData(
      color: Colors.grey[200],
    ),
    dividerColor: Colors.grey[200],
    scaffoldBackgroundColor: Colors.grey[850],
    fontFamily: "Quicksand",
  );
}
