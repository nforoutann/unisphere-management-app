import 'package:flutter/material.dart';
import 'package:frontend/objects/Course.dart';

class CourseCards extends StatelessWidget {
  final Course? course;
  final int index;

  CourseCards({super.key, required this.course, required this.index});

// Define 20 pairs of colors
  final List<List<Color>> colorPairs = [
    [Color(0xFF2D5473), Color(0xFF432D73)],
    [Colors.deepOrangeAccent.withOpacity(0.4), Colors.brown],
    [Color(0xFF8AA057), Color(0xFF114D1C)],
    [Color(0xFF732D56), Color(0xFF848C36)],
    [Color(0xFF472C6F), Color(0xFF2C6F46)],
    [Color(0xFF2C6F2E), Color(0xFF561C3F)],
    [Color(0xFF305D85), Color(0xFF853057)],
    [Color(0xFF206430), Color(0xFF388072)],
    [Color(0xFF463B6D), Color(0xFF1A4159)],
    [Color(0xFF2E5756), Color(0xFF7E3355)],
    [Color(0xFF686F2C), Color(0xFF1C5626)],
    [Color(0xFF6A7A38), Color(0xFF561C1C)],
    [Color(0xFF31696D), Color(0xFF3E6F56)],
    [Color(0xFF668023), Colors.lightGreen],
    [Color(0xFF53799B), Color(0xFF2D1766)],
    [Color(0xFF755E2F), Color(0xFF804923)],
    [Color(0xFF6A2F75), Color(0xFF752F3E)],
    [Color(0xFF2F5675), Color(0xFF362F75)],
    [Color(0xFF5D752F), Color(0xFF6F521C)],
  ];


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 5,
        child: Container(
          height: 200,
          width: 350,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colorPairs[index % colorPairs.length],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(Icons.school, size: 35),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '${course!.title}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Montserrat',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(width: 5),
                    Icon(Icons.account_circle, size: 25,),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Teacher: ${course!.teacher}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.white, // Optionally style the divider
                ),
                SizedBox(height: 10,),
                Align(
                  alignment: Alignment.centerLeft, // Align to the left
                  child: Align(
                    alignment: Alignment(-0.7, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align children to the left
                      children: [
                        Text(
                          'credit: ${course!.credit}',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Total Assignments: ${course!.numberOfDefinedAssignments}',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Best Student: ${course!.nameOfBestStudent}',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w800,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
