import 'package:flutter/material.dart';
import 'package:frontend/objects/Student.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                        const Card(
                          surfaceTintColor: Colors.indigo,
                          elevation: 15,
                          shadowColor: Colors.cyanAccent,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: Text(
                                'Card 1',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
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
                        const Card(
                          surfaceTintColor: Colors.indigo,
                          shadowColor: Colors.cyanAccent,
                          elevation: 15, // Increase this value for a more prominent shadow
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: Text(
                                'Card 2',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
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
                        const Card(
                          surfaceTintColor: Colors.indigo,
                          shadowColor: Colors.cyanAccent,
                          elevation: 15,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: Text(
                                'Card 3',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
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
                          shadowColor: Colors.indigoAccent,
                          elevation: 15,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(7),
                            child: Center(
                                child: Column(
                                  children: [
                                    const Icon(
                                        Icons.sentiment_satisfied_sharp,
                                      color: Colors.indigo,
                                    ),
                                    Center(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          'your best score is ${widget.student!.bestScore}',
                                          style: const TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w500
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
                          shadowColor: Colors.indigoAccent,
                          elevation: 15,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(7),
                            child: Center(
                              child: Column(
                                children: [
                                 const Icon(
                                      Icons.sentiment_dissatisfied_sharp,
                                    color: Colors.indigo,

                                  ),
                                  Center(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        'your worst score is ${widget.student!.worstScore}',
                                      style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w500
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