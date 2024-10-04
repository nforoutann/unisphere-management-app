import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend/screens/welcome-screen.dart';
import '../objects/Student.dart';

class ProfileScreen extends StatelessWidget {
  final Student? student;
  ProfileScreen({super.key, this.student});
  bool defaultPic = true;
  String picLink = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaQeMovPaX_94Cg4UGBU-5a70WR1eXhHRz-w&s';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF171717),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white,
            fontStyle: FontStyle.italic,
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Container(
                        height: 105,
                        width: 105,
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.grey,
                          child: Center(
                            child: defaultPic
                                ? Icon(
                              Icons.person,
                              size: 78,
                              color: Colors.white,
                            )
                                : ClipOval(
                              child: Image.network(
                                picLink,
                                fit: BoxFit.cover,
                                width: 200,
                                height: 200,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Positioned to place the IconButton at the bottom-right of the profile picture
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.all(Radius.circular(50))
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.edit, color: Colors.white),
                          iconSize: 20,
                          padding: EdgeInsets.all(0), // No padding
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                student!.name.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w800
                ),
              ),
            ),
            Center(
              child: Text(
                'student',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 220,
              height: 45,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.indigo)
                ),
                  onPressed: (){},
                  child: Text(
                      'Edit Info',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Montserrat'
                    ),

                  )
              ),
            ),
            Container(
              margin: EdgeInsets.all(30),
              padding: EdgeInsets.only(left: 30, top: 20, right: 30, bottom: 20),
              decoration: BoxDecoration(
                  color: Color(0xFF242426),
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                          child: Icon(
                              Icons.school,
                            color: Colors.indigo,
                            size: 30,
                          ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                           color: Colors.indigo.withOpacity(0.3),
                        ),
                        height: 55,
                        width: 55,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        'Student ID: ${student!.id}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Montserrat'
                        ),
                      ),
                    ],
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Container(
                        child: Icon(
                          Icons.schedule,
                          color: Colors.indigo,
                          size: 30,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.indigo.withOpacity(0.3),
                        ),
                        height: 55,
                        width: 55,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        'Current Term: ${student!.currentTerm}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Montserrat'
                        ),
                      ),
                    ],
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Container(
                        child: Icon(
                          Icons.format_list_numbered ,
                          color: Colors.indigo,
                          size: 30,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.indigo.withOpacity(0.3),
                        ),
                        height: 55,
                        width: 55,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        'Number Of Units: ${student!.credits}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Montserrat'
                        ),
                      ),
                    ],
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Container(
                        child: Icon(
                          Icons.grade,
                          color: Colors.indigo,
                          size: 30,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.indigo.withOpacity(0.3),
                        ),
                        height: 55,
                        width: 55,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        'The Total Grade: ${student!.totalGrade}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Montserrat'
                        ),
                      ),
                    ],
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  )
                ],
              ),
            ),
            Container(
              width: 120,
              height: 45,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.red.withOpacity(0.2))
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => welcomeScreen(),
                      ),
                          (Route<dynamic> route) => false, // Removes all previous routes
                    );
                  },

                  child: Text(
                    'Log Out',
                    style: TextStyle(
                        color: Color(0xFFF40011),
                        fontSize: 16,
                        fontFamily: 'Montserrat'
                    ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
