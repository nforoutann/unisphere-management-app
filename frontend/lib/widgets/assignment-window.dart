import 'package:flutter/material.dart';
import 'package:frontend/network/network-helper.dart';
import 'package:frontend/objects/Assignment.dart';

import 'login-signup-button.dart';

class AssignmentWindow extends StatelessWidget {
  final Assignment assignment;
  final String username;
  AssignmentWindow({super.key, required this.assignment, required this.username});

  TextEditingController estimatedController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  bool uploaded = false;

  String deadlineDifference(DateTime deadline) {
    DateTime now = DateTime.now();
    dynamic difference;
    if (deadline.difference(now).inDays > 0) {
      difference = '${deadline.difference(now).inDays} Days';
    } else if (deadline.difference(now).inHours > 0) {
      difference = '${deadline.difference(now).inHours} Hours';
    } else if (deadline.difference(now).inMinutes > 0) {
      difference = '${deadline.difference(now).inMinutes} Minutes';
    } else {
      difference = 'Deadline Passed!';
    }
    return difference;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Icon(
                    Icons.notifications_active,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Details',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Title: ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          TextSpan(
                            text: assignment.title,
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: RichText(
                      textAlign: TextAlign.right,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Deadline: ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          TextSpan(
                            text: deadlineDifference(assignment.deadline!),
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Align(
                alignment: Alignment(-1, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Estimated Time: ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18),
                      ),
                      flex: 1,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: estimatedController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '${assignment.estimatedTime} Hours',
                          hintStyle: TextStyle(color: Colors.white70),
                          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Align(
                alignment: Alignment(-1, 0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment(-1, 0),
                      child: Text(
                        'Description: ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
                    Align(
                      child: TextField(
                        controller: descriptionController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: '${assignment.description}',
                          hintStyle: TextStyle(color: Colors.white70),
                          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Align(
                alignment: Alignment(-1, 0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Grade: ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'Montserrat'),
                      ),
                      TextSpan(
                        text: '${assignment.score == "null" ? "Not Applied Yes" : assignment.score}',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontFamily: 'Montserrat'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 9),
              Row(
                children: [
                  Text(
                    'Your Note: ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Montserrat'),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: noteController,
                      decoration: InputDecoration(
                        hintText: 'Your Description',
                        hintStyle: TextStyle(color: Colors.white70),
                        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              if (deadlineDifference(assignment.deadline!) != 'Deadline Passed!')
                Row(
                  children: [
                    MyElevatedButton(
                        width: 230,
                        height: 30,
                        onPressed: () async {
                          await Network.editAssignment(
                            username,
                            assignment.assignmentId!,
                            estimatedController.text,
                            descriptionController.text,
                            uploaded,
                          );
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Montserrat'),
                        )),
                    SizedBox(width: 5,),
                    IconButton(
                      onPressed: () {
                        // Add upload functionality here and update the uploaded flag
                        uploaded = true;
                      },
                      icon: Icon(Icons.cloud_upload, color: Colors.cyan,),
                    )
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
