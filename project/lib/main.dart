import 'package:flutter/material.dart';
import 'package:project/route/routes.dart';
import 'package:project/screens/bottomNavBar.dart';
import 'package:project/screens/demopage.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'main',
      initialRoute: Routes.home,
      onGenerateRoute: generateRoute,
    );
  }
}
