import 'package:flutter/material.dart';

import 'package:housekeeping/routes.dart';
import 'package:housekeeping/theme/style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mein Haushalt',
      theme: darkTheme,
      initialRoute: "/",
      routes: routes,
    );
  }
}
