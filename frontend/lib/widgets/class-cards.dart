import 'package:flutter/material.dart';
import 'package:frontend/objects/Course.dart';

class CourseCards extends StatelessWidget {
  final Course? course;
  final int index;

  CourseCards({super.key, required this.course, required this.index});

// Define 20 pairs of colors
  final List<List<Color>> colorPairs = [
    [Colors.blue, Colors.purple],
    [Colors.pinkAccent, Colors.yellow],
    [Colors.limeAccent, Color(0xff17902e)],
    [Colors.blue, Colors.red],
    [Color(0xff157932), Colors.tealAccent],
    [Colors.deepPurple, Colors.indigo],
    [Colors.teal, Colors.red],
    [Colors.blueGrey, Colors.cyanAccent],
    [Colors.cyan, Colors.blueAccent],
    [Colors.amber, Colors.yellow],
    [Colors.orangeAccent, Colors.red],
    [Colors.lime, Colors.lightGreen],
    [Colors.deepOrange, Colors.orangeAccent],
    [Colors.indigoAccent, Colors.deepPurpleAccent],
    [Colors.teal, Colors.greenAccent],
    [Colors.pinkAccent, Colors.purpleAccent],
    [Colors.lightBlue, Colors.lightBlueAccent],
    [Colors.yellowAccent, Colors.amber],
    [Colors.deepOrangeAccent, Colors.brown],
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
