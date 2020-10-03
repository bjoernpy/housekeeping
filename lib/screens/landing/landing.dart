import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:housekeeping/screens/main/home/home.dart';
import 'package:housekeeping/screens/auth/login/login.dart';

class LandingScreen extends StatelessWidget {
  static const String routeName = "/";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          print("New user: ${user?.email}");
          if (user == null) {
            return LoginScreen();
          } else {
            return HomeScreen();
          }
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
