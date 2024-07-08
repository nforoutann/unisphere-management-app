import 'package:flutter/material.dart';
import 'package:frontend/network/network-helper.dart';
import 'package:frontend/objects/Task.dart';

class ToDoCard extends StatelessWidget {
  final String username;
  final Task task;
  final Widget child;
  final VoidCallback onDelete;
  final VoidCallback onDone;

  ToDoCard({super.key, required this.username, required this.task, required this.child, required this.onDelete, required this.onDone});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.cyan,
      shadowColor: Colors.cyan,
      elevation: 2,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 80), // Padding to leave space for buttons
            child: child,
          ),
          Positioned(
            right: 5,
            child: Stack(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await Network.editTask("doneTask", username, task.title, true);
                        onDone();
                      },
                      icon: const Icon(
                        Icons.check_circle_rounded,
                        color: Color(0xff1fb1a3),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await Network.editTask("deleteTask", username, task.title, true);
                        onDelete(); // Call onDelete to remove the task from the list and refresh the UI
                      },
                      icon: const Icon(
                        Icons.cancel_rounded,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: -5,
                  right: 30,
                  child: Text(
                    '${task.time.hour<10 ? '0'+task.time.hour.toString() : task.time.hour}:${task.time.minute<10 ? '0'+task.time.minute.toString() : task.time.minute}',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                    ),
                  ),
                )
              ]
            ),
          ),
        ],
      ),
    );
  }
}
