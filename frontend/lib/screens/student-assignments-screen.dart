import 'package:flutter/material.dart';
import 'package:frontend/objects/Assignment.dart';
import 'package:frontend/widgets/assignment-card.dart';
import 'package:frontend/widgets/login-signup-button.dart';
import 'package:frontend/widgets/show-assignment-info.dart';

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
                        colors: [Color(0xff898c21), Color(0xff900f5b)],
                        onTap: () {
                          setState(() {
                            _selectedAssignment = expiredAssignments[index];
                            _isViewingAssignment = true;
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          if (_isViewingAssignment)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isViewingAssignment = false;
                  });
                },
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          if (_isViewingAssignment && _selectedAssignment != null)
            ShowAssignment(
              assignment: _selectedAssignment!,
              username: widget.username,
              isViewing: _isViewingAssignment, // Pass the current state
              onClose: () { // Add a callback to update _isViewingAssignment
                setState(() {
                  _isViewingAssignment = false;
                });
              },
            ),
        ],
      ),
    );
  }
}
