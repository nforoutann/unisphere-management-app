import 'package:flutter/material.dart';
import 'package:frontend/objects/Course.dart';
import 'package:frontend/widgets/class-cards.dart';

class StudentClassScreen extends StatefulWidget {
  final List<Course> courses;
  final VoidCallback onToggleAddingCourse;

  StudentClassScreen({
    Key? key,
    required this.courses,
    required this.onToggleAddingCourse,
  }) : super(key: key);

  @override
  State<StudentClassScreen> createState() => _StudentClassScreenState();
}

class _StudentClassScreenState extends State<StudentClassScreen> {
  bool _isAddingCourse = false;

  void _toggleAddingCourse() {
    setState(() {
      _isAddingCourse = !_isAddingCourse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(), // Disable ListView scrolling
                  shrinkWrap: true, // Ensure it takes up only the necessary height
                  itemCount: widget.courses.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CourseCards(
                        course: widget.courses[index],
                        index: index, // Pass the index to the CourseCards widget
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
