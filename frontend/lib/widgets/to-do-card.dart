import 'package:flutter/material.dart';
import 'package:frontend/network/network-helper.dart';
import 'package:frontend/objects/Student.dart';
import 'package:frontend/objects/Task.dart';

class ToDoCard extends StatelessWidget {
  final Student? student;
  final Task? task;
  final Widget? child;

  ToDoCard({super.key, required this.student, required this.task, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.cyan,
      shadowColor: Colors.cyan,
      elevation: 2,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 70), // Padding to leave space for buttons
            child: child,
          ),
          Positioned(
            right: 5,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () async {
                    Network.editTask("doneTask", student!.username, task!.title, true);
                  },
                  icon:const Icon(
                    Icons.check_circle_rounded,
                    color: Color(0xff1fb1a3),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    Network.editTask("deleteTask", student!.username, task!.title, true);
                  },
                  icon:const Icon(
                    Icons.cancel_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
