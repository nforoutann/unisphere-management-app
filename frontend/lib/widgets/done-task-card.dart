import 'package:flutter/material.dart';
import 'package:frontend/network/network-helper.dart';
import 'package:frontend/objects/Task.dart';

class DoneTaskCard extends StatelessWidget{
  DoneTaskCard({super.key, required this.child, required this.username, required this.task, required this.onDelete});
  final Widget child;
  final String username;
  final Task task;
  final VoidCallback onDelete;


  @override
  Widget build(BuildContext context){
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
            top: 5,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
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
          ),
        ],
      ),
    );
  }

}