import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:frontend/widgets/main-scaffold.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentMain(),
    ),
  );
}

class StudentMain extends StatefulWidget {
  @override
  _StudentMainState createState() => _StudentMainState();
}

class _StudentMainState extends State<StudentMain> {
  int _currentIndex = 2; // Initial index

  static List<Widget> _pages = <Widget>[

  ];

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      child: Text('hi'), // Replace with your main content widget
      navigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 60,
        color: Colors.indigo,
        buttonBackgroundColor: Colors.cyan,
        backgroundColor: Color(0xFF171717),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 230),
        items: <Widget>[
          Icon(Icons.checklist, size: 30),
          Icon(Icons.assignment_outlined, size: 30),
          Icon(Icons.home, size: 30),
          Icon(Icons.school, size: 30),
          Icon(Icons.newspaper, size: 30),

        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            // Handle tapping of navigation items if needed
          });
        },
      ),
    );
  }
}
