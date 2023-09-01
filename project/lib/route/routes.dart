import 'package:flutter/material.dart';
import 'package:project/Auth/forget_password.dart';
import 'package:project/Auth/login.dart';
import 'package:project/Auth/registration.dart';
import 'package:project/Auth/splash_screen.dart';
import 'package:project/screens/Profile/profilepage.dart';
import 'package:project/screens/home.dart';

import '../screens/bottomNavBar.dart';

class Routes {
  static const String first = '/';
  static const String splash = 'splash';
  static const String login = 'login';

  static const String profile = 'profile';
  static const String signup = 'signup';
  static const String forget_password = 'forget_password';
  static const String home = 'home';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.first:
      return MaterialPageRoute(
          builder: (context) => BottomNavBar(
                username: '',
              ));
    case Routes.profile:
      return MaterialPageRoute(builder: (context) => ProfilePage(username: ''));
    case Routes.splash:
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    case Routes.login:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case Routes.signup:
      return MaterialPageRoute(builder: (context) => const SignUpPage());
    case Routes.forget_password:
      return MaterialPageRoute(builder: (context) => const ForgetPassword());
    case Routes.home:
      return MaterialPageRoute(builder: (context) => const HomePage());
    default:
      return MaterialPageRoute(
          builder: (context) => BottomNavBar(
                username: '',
              ));
  }
}
