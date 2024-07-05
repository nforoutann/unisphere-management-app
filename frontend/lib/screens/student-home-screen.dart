import 'package:flutter/material.dart';
import 'package:frontend/objects/Student.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StudentHomeScreen extends StatefulWidget {
  Student? student;

  StudentHomeScreen({Key? key,  this.student}) : super(key: key);

  @override
  _StudentHomeScreenState createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(8.0),
                          color: Colors.indigo,
                        ),
                        Card(
                          surfaceTintColor: Colors.indigo,
                          elevation: 10,
                          shadowColor: Colors.cyanAccent,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Center(
                              child: Column(
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.heartCrack,
                                    size: 20,
                                    color: Colors.indigo,
                                  ),
                                  Center(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        'you have ${widget.student!.numberOfExams} exams',
                                        style: const TextStyle(
                                            fontFamily: 'Georgia',
                                            letterSpacing: 0.8,
                                            fontWeight: FontWeight.w600
                                        ),
                                      )
                                  )
                                ],
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(8.0),
                          color: Colors.indigo,
                        ),
                        Card(
                          surfaceTintColor: Colors.indigo,
                          shadowColor: Colors.cyanAccent,
                          elevation: 10,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Center(
                              child: Column(
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.pen,
                                    size: 20,
                                    color: Colors.indigo,
                                  ),
                                  Center(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        '${widget.student!.numberOfLeftAssignments} exercises left',
                                        style: const TextStyle(
                                            fontFamily: 'Georgia',
                                            letterSpacing: 0.8,
                                            fontWeight: FontWeight.w600
                                        ),
                                      )
                                  )
                                ],
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(8.0),
                          color: Colors.indigo,
                        ),
                        Card(
                          surfaceTintColor: Colors.indigo,
                          shadowColor: Colors.cyanAccent,
                          elevation: 10,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Center(
                              child: Column(
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.explosion,
                                    size: 20,
                                    color: Colors.indigo,
                                  ),
                                  Center(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        'lost ${widget.student!.numberOfLostAssignments==null ? 0 : widget.student!.numberOfLostAssignments} deadlines',
                                        style: const TextStyle(
                                            fontFamily: 'Georgia',
                                            letterSpacing: 0.8,
                                            fontWeight: FontWeight.w600,
                                        ),
                                      )
                                  )
                                ],
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Spacer(flex: 1),
                  Expanded(
                    flex: 3,
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(8.0),
                          color: Colors.indigo,
                        ),
                        Card(
                          surfaceTintColor: Colors.indigo,
                          shadowColor: Colors.cyanAccent,
                          elevation: 10,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(7),
                            child: Center(
                                child: Column(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.faceSmile,
                                      size: 20,
                                      color: Colors.indigo,
                                    ),
                                    Center(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          'your best score is ${widget.student!.bestScore}',
                                          style: const TextStyle(
                                              fontFamily: 'Georgia',
                                              letterSpacing: 0.8,
                                              fontWeight: FontWeight.w600
                                          ),
                                        )
                                    )
                                  ],
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(8.0),
                          color: Colors.indigo,
                        ),
                        Card(
                          surfaceTintColor: Colors.indigo,
                          shadowColor: Colors.cyanAccent,
                          elevation: 10,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(7),
                            child: Center(
                              child: Column(
                                children: [
                                 const FaIcon(
                                   FontAwesomeIcons.faceFrown,
                                   size: 20,
                                   color: Colors.indigo,
                                 ),
                                  Center(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        'your worst score is ${widget.student!.worstScore}',
                                      style: const TextStyle(
                                          fontFamily: 'Georgia',
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w600
                                      ),
                                    )
                                  )
                                ],
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(flex: 1),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: const Center(
              child: Text(
                'Second Part',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: const Center(
              child: Text(
                'Third Part',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}