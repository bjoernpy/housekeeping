import 'package:flutter/widgets.dart';
import 'package:housekeeping/screens/grocery_list/grocery_list.dart';

import 'package:housekeeping/screens/home/home.dart';
import 'package:housekeeping/screens/settings/settings.dart';

class RouteNames {
  static final home = HomeScreen.routeName;
  static final settings = SettingsScreen.routeName;
  static final groceryList = GroceryListScreen.routeName;
}

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  RouteNames.home: (BuildContext context) => HomeScreen(),
  RouteNames.groceryList: (BuildContext context) => GroceryListScreen(),
  RouteNames.settings: (BuildContext context) => SettingsScreen(),
};
