import 'package:flutter/material.dart';
import 'package:project/screens/Profile/profilepage.dart';

import '../screens/bottomNavBar.dart';
import '../screens/demopage.dart';

class Routes {
  static const String home = '/';
  static const String second = '/second';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.home:
      return MaterialPageRoute(builder: (context) => const BottomNavBar());
    case Routes.second:
      return MaterialPageRoute(builder: (context) => const ProfilePage());
    default:
      return MaterialPageRoute(builder: (context) => const BottomNavBar());
  }
}
