import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:frontend/network/network-helper.dart';
import 'package:frontend/objects/Student.dart';
import 'package:frontend/screens/student-assignments-screen.dart';
import 'package:frontend/screens/student-classes-screen.dart';
import 'package:frontend/screens/student-home-screen.dart';
import 'package:frontend/screens/student-news-screen.dart';
import 'package:frontend/screens/to-do-list-screen.dart';
import 'package:frontend/widgets/main-scaffold.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentMain(username: "nazanin"),
    ),
  );
}

class StudentMain extends StatefulWidget {
  final String username;

  StudentMain({required this.username});

  @override
  _StudentMainState createState() => _StudentMainState();
}

class _StudentMainState extends State<StudentMain> {
  int _currentIndex = 2; // Initial index
  Student? student;

  @override
  void initState() {
    super.initState();
    if (_currentIndex == 2) {
      _fetchStudent();
    }
  }

  Future<void> _fetchStudent() async {
    try {
      Student fetchedStudent = await Network.getStudent(widget.username);
      setState(() {
        student = fetchedStudent;
      });
    } catch (e) {
      print('Error fetching student: $e');
    }
  }

  Widget _pages(int index) {
    List<Widget> pagesList = <Widget>[
      ToDoScreen(),
      StudentAssignmentScreen(),
      student != null ? StudentHomeScreen(student: student!) : Center(child: CircularProgressIndicator()),
      StudentClassScreen(),
      StudentNewsScreen(),
    ];
    return pagesList[index];
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<String> texts = ['To-Do', 'Assignments', 'Home', 'Classes', 'News'];

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      text: texts[_currentIndex],
      child: _pages(_currentIndex),
      navigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 60,
        color: Colors.indigo,
        buttonBackgroundColor: Colors.cyan,
        backgroundColor: Color(0xFF171717),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 230),
        items: const <Widget>[
          Icon(Icons.checklist, size: 30),
          Icon(Icons.assignment_outlined, size: 30),
          Icon(Icons.home, size: 30),
          Icon(Icons.school, size: 30),
          Icon(Icons.newspaper, size: 30),
        ],
        onTap: (index) {
          setState(() {
            if (index == 2) {
              _fetchStudent();
            }
            _currentIndex = index;
          });
        },
      ),
    );
  }
}