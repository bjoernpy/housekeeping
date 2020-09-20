import 'package:flutter/material.dart';
import 'package:housekeeping/components/nav_drawer.dart';

class SettingsScreen extends StatefulWidget {
  static final String routeName = "/settings";

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Einstellungen"),
      ),
      drawer: NavDrawer(),
      body: Center(child: Text("data")),
    );
  }
}
