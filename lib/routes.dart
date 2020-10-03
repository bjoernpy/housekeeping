import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:housekeeping/screens/auth/create_user/create_user.dart';
import 'package:housekeeping/screens/main/grocery_list/grocery_list.dart';
import 'package:housekeeping/screens/main/home/home.dart';
import 'package:housekeeping/screens/auth/login/login.dart';
import 'package:housekeeping/screens/auth/registration/registration.dart';
import 'package:housekeeping/screens/landing/landing.dart';
import 'package:housekeeping/screens/main/settings/settings.dart';

class RouteNames {
  static const createUser = CreateUserScreen.routeName;
  static const groceryList = GroceryListScreen.routeName;
  static const home = HomeScreen.routeName;
  static const landing = LandingScreen.routeName;
  static const login = LoginScreen.routeName;
  static const register = RegistrationScreen.routeName;
  static const settings = SettingsScreen.routeName;
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.landing:
        return MaterialPageRoute(builder: (BuildContext context) => LandingScreen(), settings: settings);
      case RouteNames.login:
        return MaterialPageRoute(builder: (BuildContext context) => LoginScreen(), settings: settings);
      case RouteNames.register:
        return MaterialPageRoute(builder: (BuildContext context) => RegistrationScreen(), settings: settings);
      case RouteNames.createUser:
        return MaterialPageRoute(builder: (BuildContext context) => CreateUserScreen(), settings: settings);
      case RouteNames.home:
        return MaterialPageRoute(builder: (BuildContext context) => HomeScreen(), settings: settings);
      case RouteNames.groceryList:
        return MaterialPageRoute(
          builder: (BuildContext context) => GroceryListScreen(user: settings.arguments),
          settings: settings,
        );
      case RouteNames.settings:
        return MaterialPageRoute(
          builder: (BuildContext context) => SettingsScreen(user: settings.arguments),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("No route defined for ${settings.name}"),
            ),
          ),
        );
    }
  }
}
