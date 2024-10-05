import 'package:flutter/material.dart';
import 'package:frontend/objects/Assignment.dart';
import 'package:frontend/objects/date-hour.dart';
import 'package:frontend/widgets/assignment-card.dart';
import 'package:frontend/widgets/assignment-window.dart';

class StudentAssignmentScreen extends StatefulWidget {
  final String username;
  final List<Assignment>? assignments;

  StudentAssignmentScreen({Key? key, required this.assignments, required this.username}) : super(key: key);

  @override
  State<StudentAssignmentScreen> createState() => _StudentAssignmentScreenState();
}

class _StudentAssignmentScreenState extends State<StudentAssignmentScreen> {
  bool _isViewingAssignment = false;
  Assignment? _selectedAssignment;

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
      child: Stack(
        children: [
          SingleChildScrollView(
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
                        onTap: () {
                          setState(() {
                            _selectedAssignment = ongoingAssignments[index];
                            _isViewingAssignment = true;
                          });
                          _showAssignmentDialog(context, _selectedAssignment!);
                        },
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
                        colors: [Color(0xFF43431D), Color(0xFF491221)],
                        onTap: () {
                          setState(() {
                            _selectedAssignment = expiredAssignments[index];
                            _isViewingAssignment = true;
                          });
                          _showAssignmentDialog(context, _selectedAssignment!);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAssignmentDialog(BuildContext context, Assignment assignment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 170, horizontal: 20),
          child: Stack(
            children: [
              // Bottom layer
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                ),
              ),
              // Top layer
              Container(
                margin: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Color(0xFF171717),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              AssignmentWindow(assignment: assignment, username: widget.username,), // Pass the selected assignment
            ],
          ),
        );
      },
    );
  }
}