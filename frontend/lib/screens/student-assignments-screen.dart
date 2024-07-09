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
  @override
  Widget build(BuildContext context) {
    List<Assignment> ongoingAssignments = widget.assignments!.where((assignment) => assignment.deadline!.isAfter(DateTime.now())).toList();
    List<Assignment> expiredAssignments = widget.assignments!.where((assignment) => assignment.deadline!.isBefore(DateTime.now())).toList();

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
                  return AssignmentCard(assignment: ongoingAssignments[index]);
                },
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: expiredAssignments.length,
                itemBuilder: (context, index) {
                  return AssignmentCard(assignment: expiredAssignments[index], colors: [Color(0xff898c21), Color(0xff900f5b)]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
