import 'package:flutter/material.dart';

import 'demopage.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentTab = 0;
  final List<Widget> screens = [
    Demo(),
    Demo(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
