import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/objects/Assignment.dart';
import 'package:frontend/widgets/assignment-card.dart';

class StudentAssignmentScreen extends StatefulWidget {
  final List<Assignment>? assignments;
  StudentAssignmentScreen({super.key, required this.assignments});

  @override
  State<StudentAssignmentScreen> createState() => _StudentAssignmentScreenState();
}

class _StudentAssignmentScreenState extends State<StudentAssignmentScreen> {
  TextEditingController _estimatedTimeController = TextEditingController();
  TextEditingController _gradeController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  File? _selectedFile;

  void _showAssignmentDialog(Assignment assignment) {
    DateTime now = DateTime.now();
    dynamic difference;
    if (assignment.deadline!.difference(now).inDays != 0) {
      difference = '${assignment.deadline!.difference(now).inDays} Days';
    } else if (assignment.deadline!.difference(now).inHours != 0) {
      difference = '${assignment.deadline!.difference(now).inHours} Hours';
    } else if (assignment.deadline!.difference(now).inMinutes != 0) {
      difference = '${assignment.deadline!.difference(now).inMinutes} Minutes';
    } else {
      difference = 'Deadline Passed!';
    }

    _estimatedTimeController.text = assignment.estimatedTime.toString();
    _gradeController.text = ''; // Clear previous text
    _descriptionController.text = ''; // Clear previous text
    _selectedFile = null; // Clear previous file selection

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Details',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontStyle: FontStyle.italic,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.notifications_active),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                ),
                Text(
                  'Title: ${assignment.title}',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  'Deadline: $difference',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Estimated Time:',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          controller: _estimatedTimeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter estimated time',
                            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: IconButton(onPressed: (){}, icon: Icon(Icons.edit))
                    )
                  ],
                ),
                Text(
                  'Description:',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: _descriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Enter description',
                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Grade:',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 8),
                SizedBox(height: 16),
                Text(
                  'Upload File:',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _selectedFile != null
                          ? Text(
                        'File: ${_selectedFile!.path}',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                        ),
                      )
                          : SizedBox.shrink(),
                      IconButton(
                        icon: Icon(Icons.attach_file),
                        onPressed: () async {
                          try {
                            FilePickerResult? result = await FilePicker.platform.pickFiles();
                            if (result != null) {
                              setState(() {
                                _selectedFile = File(result.files.single.path!);
                              });
                            }
                          } catch (e) {
                            print('Error picking file: $e');
                            // Handle error gracefully (show a snackbar, alert dialog, etc.)
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement save logic here
                      Navigator.of(context).pop();
                    },
                    child: Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    List<Assignment> ongoingAssignments = widget.assignments!
        .where((assignment) => assignment.deadline!.isAfter(DateTime.now()))
        .toList();
    List<Assignment> expiredAssignments = widget.assignments!
        .where((assignment) => assignment.deadline!.isBefore(DateTime.now()))
        .toList();

    return Padding(
      padding: EdgeInsets.only(bottom: 13),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 5),
          child: Column(
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: ongoingAssignments.length,
                itemBuilder: (context, index) {
                  return AssignmentCard(
                    assignment: ongoingAssignments[index],
                    onTap: () => _showAssignmentDialog(ongoingAssignments[index]),
                  );
                },
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: expiredAssignments.length,
                itemBuilder: (context, index) {
                  return AssignmentCard(
                    assignment: expiredAssignments[index],
                    colors: [Color(0xff898c21), Color(0xff900f5b)],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _estimatedTimeController.dispose();
    _descriptionController.dispose();
    _gradeController.dispose();
    super.dispose();
  }
}
