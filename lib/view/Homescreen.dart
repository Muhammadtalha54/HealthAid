import 'package:flutter/material.dart';
import 'package:healthaid/view/Analysissreen.dart';
import 'package:healthaid/view/historyscreen.dart';

import 'package:healthaid/view/profilescreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    AnalysisScreen(),
    MoodHistoryScreen(),
    ProfileSettingsScreen(),
  ];

  void _handlePageChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 208, 85, 229),
      body: _pages[_currentIndex], // Display the selected page directly
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _handlePageChange,
        backgroundColor: const Color.fromARGB(255, 211, 108, 229),
        unselectedItemColor: const Color.fromARGB(255, 69, 68, 68),
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: "Mood History"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
