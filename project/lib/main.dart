import 'package:flutter/material.dart';
import 'package:project/Auth/forget_password.dart';
import 'package:project/Home/homepage.dart';

import 'Auth/login.dart';
import 'Auth/registration.dart';
import 'Auth/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'splash_screen',
      routes: {
      'splash_screen' :(context) => SplashScreen(),
      'login' : (context) => LoginPage(),
      'signup' : (context) => SignUpPage(),
      'forget_password' : (context) => ForgetPassword(),
      'home' : (context) => HomeScreen()
      },
    );
  }
}

