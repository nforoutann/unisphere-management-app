import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/network/network-helper.dart';
import 'package:frontend/objects/Assignment.dart';
import 'package:frontend/widgets/login-signup-button.dart';

class ShowAssignment extends StatefulWidget {
  final Assignment assignment;
  final String username;
  final bool isViewing; // Ensure it's not nullable

  // Add a callback to update parent state when closing
  final VoidCallback onClose;

  ShowAssignment({
    Key? key,
    required this.assignment,
    required this.username,
    required this.isViewing,
    required this.onClose,
  }) : super(key: key);

  @override
  State<ShowAssignment> createState() => _ShowAssignmentState();
}

class _ShowAssignmentState extends State<ShowAssignment> {
  TextEditingController estimateTimeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController studentsDescriptionController = TextEditingController();

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
  void initState() {
    super.initState();
    estimateTimeController.text = widget.assignment.estimatedTime.toString();
    descriptionController.text = widget.assignment.description!;
    studentsDescriptionController.text = ''; // Initialize if needed
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 1.0, end: 0.0),
        duration: Duration(milliseconds: 300),
        builder: (context, value, child) {
          final screenHeight = MediaQuery.of(context).size.height;
          final containerHeight = screenHeight / 1.5;

          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Transform.translate(
              offset: Offset(0, 160 * (1 - value)),
              child: Container(
                height: containerHeight,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        height: containerHeight + 180,
                        margin: EdgeInsets.only(top: 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        height: containerHeight + 180,
                        margin: const EdgeInsets.only(top: 20, bottom: 0),
                        decoration: BoxDecoration(
                          color: Color(0xFF171717),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.notifications_active, color: Colors.white,),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      child: Text(
                                        'Title: ${widget.assignment.title}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Montserrat',
                                            fontSize: 16
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Deadline: ${deadlineDifference(widget.assignment.deadline!)}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat',
                                          fontSize: 16
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Estimated Time: ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Montserrat',
                                            fontSize: 16
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: estimateTimeController,
                                        decoration: InputDecoration(
                                          labelText: '${widget.assignment.estimatedTime} Hours',
                                          labelStyle: TextStyle(color: Colors.white),
                                          border: OutlineInputBorder(),
                                          filled: true,
                                          fillColor: Color(0xFF333333),
                                        ),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a number';
                                          }
                                          return null;
                                        },
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.edit, color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Description:',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontSize: 18
                                  ),
                                ),
                                SizedBox(height: 15,),
                                TextFormField(
                                  controller: descriptionController,
                                  decoration: InputDecoration(
                                    labelText: '${widget.assignment.description}',
                                    labelStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Color(0xFF333333),
                                  ),
                                  maxLines: 2,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a description';
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontSize: 16
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  'Student Description:',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontSize: 18
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  controller: studentsDescriptionController,
                                  decoration: InputDecoration(
                                    labelText: 'Description',
                                    labelStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Color(0xFF333333),
                                  ),
                                  maxLines: 2,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a description';
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontSize: 16
                                  ),
                                ),
                                SizedBox(height: 20,),
                                if(deadlineDifference(widget.assignment.deadline!) != 'Deadline Passed!')
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      MyElevatedButton(
                                        onPressed: () {
                                          // Implement your update logic here
                                          Network.editAssignment(
                                            widget.username,
                                            widget.assignment.assignmentId!,
                                            estimateTimeController.text,
                                            descriptionController.text,
                                            false,
                                          ).then((_) {
                                            widget.onClose(); // Close the assignment view
                                          }).catchError((error) {
                                            // Handle error
                                          });
                                        },
                                        width: 120,
                                        child: Text(
                                          'Submit',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Montserrat',
                                              fontSize: 18
                                          ),
                                        ),
                                      ),
                                      MyElevatedButton(
                                        onPressed: () {
                                          // Implement your upload file logic here
                                          setState(() {
                                            // Handle file upload
                                          });
                                        },
                                        width: 130,
                                        child: Text(
                                          'Upload File',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Montserrat',
                                              fontSize: 13
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}