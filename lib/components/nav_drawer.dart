import 'package:flutter/material.dart';
import 'package:housekeeping/routes.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              "Mein Haushalt",
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Colors.red[700],
                  Colors.black,
                ],
              ),
            ),
          ),
          ListTile(
            title: Text("Home"),
            leading: Icon(Icons.home),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushReplacementNamed(context, RouteNames.home);
            },
          ),
          ListTile(
            title: Text("Einkaufsliste"),
            leading: Icon(Icons.format_list_bulleted),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushReplacementNamed(context, RouteNames.groceryList);
            },
          ),
          ListTile(
            title: Text("Einstellungen"),
            leading: Icon(Icons.settings),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushReplacementNamed(context, RouteNames.settings);
            },
          ),
        ],
      ),
    );
  }
}
