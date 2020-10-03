import 'package:flutter/material.dart';

import 'package:housekeeping/models/user_data.dart';
import 'package:housekeeping/routes.dart';
import 'package:housekeeping/services/auth_service.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({
    Key key,
    @required this.user,
  }) : super(key: key);

  final UserData user;

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
              widget.user.firstName,
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
              // Push until route = "/" because the home is loaded inside the landing page
              Navigator.popUntil(context, ModalRoute.withName(RouteNames.landing));
            },
          ),
          ListTile(
            title: Text("Grocery List"),
            leading: Icon(Icons.format_list_bulleted),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              if (ModalRoute.of(context).settings.name == RouteNames.groceryList)
                Navigator.pop(context);
              else
                Navigator.pushNamed(context, RouteNames.groceryList, arguments: widget.user);
            },
          ),
          ListTile(
            title: Text("Settings"),
            leading: Icon(Icons.settings),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              if (ModalRoute.of(context).settings.name == RouteNames.settings)
                Navigator.pop(context);
              else
                Navigator.pushNamed(context, RouteNames.settings, arguments: widget.user);
            },
          ),
          ListTile(
            title: Text("Logout"),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              authService.signOut();
            },
          )
        ],
      ),
    );
  }
}
