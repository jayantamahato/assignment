import 'package:assignment/view/screens/calls/calls.dart';
import 'package:assignment/view/screens/followScreen.dart/followScreen.dart';
import 'package:flutter/material.dart';

import '../calling/voice_call.dart';
import '../home/home.dart';

class BottomNavigationScreen extends StatefulWidget {
  static String route = '/';

  BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int currentIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    CallsScreen(),
    Followscreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'Calls'),
            BottomNavigationBarItem(
                icon: Icon(Icons.people), label: 'Followers'),
          ]),
    );
  }
}
