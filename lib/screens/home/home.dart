import 'package:flutter/material.dart';
import 'package:housekeeping/components/nav_drawer.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = "/";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Haushalt Daheim"),
      ),
      drawer: NavDrawer(),
      body: Center(
        child: Text("Screen Home"),
      ),
    );
  }
}
