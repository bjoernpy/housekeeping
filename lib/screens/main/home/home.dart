import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:housekeeping/widgets/nav_drawer.dart';
import 'package:housekeeping/models/user_data.dart';
import 'package:housekeeping/routes.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User authUser = FirebaseAuth.instance.currentUser;
  UserData user;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      try {
        // Get the user document
        FirebaseFirestore.instance.collection("users").doc(authUser.uid).get().then((DocumentSnapshot userDoc) {
          if (!userDoc.exists) {
            Navigator.pushReplacementNamed(context, RouteNames.createUser);
          } else {
            Map<String, dynamic> userData = userDoc.data();
            FirebaseFirestore.instance
                .collection("households")
                .doc(userData["households"][0])
                .get()
                .then((DocumentSnapshot householdDoc) {
              String householdName = householdDoc.data()["name"];

              if (mounted)
                setState(() {
                  _loading = false;
                  user = UserData.fromData(authUser.uid, userData, householdName);
                });
            });
          }
        });
      } on Exception catch (e) {
        print(e);
        if (mounted)
          setState(() {
            _loading = false;
          });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: alertExitDialog,
      child: Scaffold(
        appBar: AppBar(
          title: Text(user?.householdName ?? "My household"),
        ),
        drawer: _loading ? Drawer() : NavDrawer(user: user),
        body: _loading
            ? Container(child: Center(child: CircularProgressIndicator()))
            : Padding(
                padding: EdgeInsets.fromLTRB(30, 30, 30, 20),
                child: Column(
                  children: [Text("Hello ${user?.firstName}")],
                ),
              ),
      ),
    );
  }

  Future<bool> alertExitDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Exit App"),
        content: Text("Do you want to exit the App"),
        actions: [
          FlatButton(onPressed: () => Navigator.pop(context, false), child: Text("NO")),
          FlatButton(onPressed: () => Navigator.pop(context, true), child: Text("YES")),
        ],
      ),
    );
  }
}
