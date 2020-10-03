import 'package:flutter/material.dart';

import 'package:housekeeping/widgets/nav_drawer.dart';
import 'package:housekeeping/models/user_data.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = "/settings";

  const SettingsScreen({
    Key key,
    @required this.user,
  }) : super(key: key);

  final UserData user;

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      drawer: NavDrawer(user: widget.user),
      body: Center(child: Text("data")),
    );
  }
}
