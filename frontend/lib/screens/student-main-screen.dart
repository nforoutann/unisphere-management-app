import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:frontend/network/network-helper.dart';
import 'package:frontend/objects/Assignment.dart';
import 'package:frontend/objects/Course.dart';
import 'package:frontend/objects/Student.dart';
import 'package:frontend/screens/student-assignments-screen.dart';
import 'package:frontend/screens/student-classes-screen.dart';
import 'package:frontend/screens/student-home-screen.dart';
import 'package:frontend/screens/student-news-screen.dart';
import 'package:frontend/screens/to-do-list-screen.dart';
import 'package:frontend/widgets/add-course.dart';
import 'package:frontend/widgets/main-scaffold.dart';
import 'package:frontend/objects/Task.dart';

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
  List<Task>? tasks;
  List<Course>? courses;
  bool _isAddingCourse = false; // Track the state for adding a course
  List<Assignment>? assignments;

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

  Future<void> _fetchListTasks() async {
    try {
      List<Task> taskList = await Network.getTasks(widget.username);
      setState(() {
        tasks = taskList;
      });
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  Future<void> _fetchListCourses() async {
    try {
      List<Course> courseList = await Network.getCourses(widget.username);
      setState(() {
        courses = courseList;
      });
    } catch (e) {
      print('Error fetching courses: $e');
    }
  }

  Future<void> _fetchListAssignments() async {
    try {
      List<Assignment> assignmentList = await Network.getAssignments(widget.username);
      setState(() {
        assignments = assignmentList;
      });
    } catch (e) {
      print('Error fetching courses: $e');
    }
  }

  void _toggleAddingCourse() {
    setState(() {
      _isAddingCourse = !_isAddingCourse;
    });
  }

  Widget _pages(int index) {
    List<Widget> pagesList = <Widget>[
      tasks != null ? ToDoScreen(tasks: tasks!, username: widget.username) : Center(child: CircularProgressIndicator()),
      assignments != null ? StudentAssignmentScreen(assignments: assignments, username: widget.username) : Center(child: CircularProgressIndicator()),
      student != null ? StudentHomeScreen(student: student!) : Center(child: CircularProgressIndicator()),
      courses != null ? StudentClassScreen(courses: courses!, onToggleAddingCourse: _toggleAddingCourse) : Center(child: CircularProgressIndicator()),
      StudentNewsScreen(),
    ];

    if (index == 3) {
      return Padding(
        padding: EdgeInsets.only(bottom: _isAddingCourse ? 100 : 0),
        child: Stack(
          children: [
            pagesList[index],
            if (_isAddingCourse)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isAddingCourse = false;
                    });
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
            if (_isAddingCourse)
              Padding(
                padding: EdgeInsets.only(bottom: 200),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 1.0, end: 0.0),
                  duration: Duration(milliseconds: 300),
                  builder: (context, value, child) {
                    // Calculate half of screen height
                    final screenHeight = MediaQuery.of(context).size.height;
                    final containerHeight = screenHeight / 2;

                    return Transform.translate(
                      offset: Offset(0, 230),
                      child: Container(
                        height: containerHeight,
                        child: Stack(
                          children: [
                            Container(
                              height: containerHeight + 80, // Ensure the height covers the screen
                              margin: EdgeInsets.only(top: 45),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                            ),
                            Container(
                              height: 600,
                              margin: const EdgeInsets.only(top: 60, bottom: 0), // Adjust the top margin to reveal the white background
                              decoration: const BoxDecoration(
                                color: Color(0xFF171717),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              child: AddCourse(onClose: _toggleAddingCourse, username: widget!.username,),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      );
    } else {
      return pagesList[index];
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      if(index == 1){
        _fetchListAssignments();
      }else if (index == 2) {
        _fetchStudent();
      } else if (index == 0) {
        _fetchListTasks();
      } else if (index == 3) {
        _fetchListCourses();
      }
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
          _onItemTapped(index);
        },
      ),
      firstButton: _currentIndex == 3
          ? IconButton(
            icon: Icon(Icons.add_circle_rounded),
            onPressed: _toggleAddingCourse,
          )
          : null,
      secondButton: _currentIndex == 3
          ? IconButton(
            icon: Icon(Icons.assignment),
            onPressed: () {},
          )
          : null,
    );
  }
}
