import 'package:flutter/material.dart';
import 'package:frontend/screens/welcome-screen.dart';
import 'package:frontend/widgets/ChangePassword.dart';
import 'package:frontend/widgets/login-signup-button.dart';
import '../objects/Student.dart';

class ProfileScreen extends StatefulWidget {
  final Student? student;
  ProfileScreen({super.key, this.student});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState(student: student!);
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool defaultPic = true;
  String picLink = '';
  Student student;
  _ProfileScreenState({required this.student});
  //https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaQeMovPaX_94Cg4UGBU-5a70WR1eXhHRz-w&s

  TextEditingController link = TextEditingController();

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
      body: SingleChildScrollView(
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
                      decoration:const BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.all(Radius.circular(50))
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () { //todo
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(5),  // Padding is applied here
                                    decoration: BoxDecoration(
                                      color: Colors.white,  // Background color
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Container(
                                      height: 280,  // Adjust height as needed
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                        color: Color(0xFF171717),  // This ensures white space inside
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(25),
                                        child: Column(
                                          children: [
                                            SizedBox(height: 10,),
                                            const Text(
                                              'Change Avatar',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 23,
                                                fontFamily: 'Montserrat',
                                                fontStyle: FontStyle.italic
                                              ),
                                            ),
                                            const SizedBox(height: 20,),
                                            TextFormField(
                                              controller: link,
                                              decoration: const InputDecoration(
                                                labelText: 'Enter The Link Of The Pic',
                                                labelStyle: TextStyle(
                                                  fontFamily: 'Montserrat'
                                                ),
                                                border: OutlineInputBorder(),
                                              ),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                            const SizedBox(height: 40,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                MyElevatedButton(
                                                    onPressed: (){
                                                      setState(() {
                                                        defaultPic = true;
                                                      });
                                                      Navigator.of(context).pop();
                                                    },
                                                  width: 130,
                                                    child: const Text(
                                                      'Default',
                                                      style: TextStyle(
                                                          color: Colors.white
                                                      ),
                                                    ),
                                                ),
                                                MyElevatedButton(
                                                  width: 130,
                                                    onPressed: (){
                                                      setState(() {
                                                        picLink = link.text;
                                                        defaultPic = false;
                                                        Navigator.of(context).pop();
                                                      });

                                                    },
                                                    child: const Text(
                                                        'Apply',
                                                      style: TextStyle(
                                                        color: Colors.white
                                                      ),
                                                    )
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          //todo send the link of the online image
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
            const SizedBox(height: 20),
            Center(
              child: Text(
                widget.student!.name.toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w800
                ),
              ),
            ),
            const Center(
              child: Text(
                'student',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              width: 220,
              height: 45,
              child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.indigo)
                  ),
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return Dialog(
                            child: Container(
                              width: 200,
                              height: 200,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(6))
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF171717),
                                ),
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Ask Admin To Change Your Info. \n You Cannot Change Your Info By Your Own.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Montserrat',
                                        fontSize: 13
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                    );
                  },
                  child: const Text(
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
              padding: EdgeInsets.only(left: 20, top: 20, right: 30, bottom: 20),
              decoration: BoxDecoration(
                  color: Color(0xFF242426),
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              color: Colors.indigo.withOpacity(0.3),
                            ),
                            height: 55,
                            width: 55,
                            child: const Icon(
                              Icons.school,
                              color: Colors.indigo,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 10,),
                          const Text(
                            'Student ID: ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Montserrat'
                            ),
                          ),
                        ],
                      ),
                      Text(
                        ' ${widget.student!.id}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Montserrat'
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              color: Colors.indigo.withOpacity(0.3),
                            ),
                            height: 55,
                            width: 55,
                            child: const Icon(
                              Icons.schedule,
                              color: Colors.indigo,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 10,),
                          const Text(
                            'Curent Term: ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Montserrat'
                            ),
                          ),
                        ],
                      ),
                      Text(
                        ' ${widget.student!.currentTerm}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Montserrat'
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              color: Colors.indigo.withOpacity(0.3),
                            ),
                            height: 55,
                            width: 55,
                            child: const Icon(
                              Icons.format_list_numbered,
                              color: Colors.indigo,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 10,),
                          const Text(
                            'Number Of Units: ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Montserrat'
                            ),
                          ),
                        ],
                      ),
                      Text(
                        ' ${widget.student!.credits}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Montserrat'
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              color: Colors.indigo.withOpacity(0.3),
                            ),
                            height: 55,
                            width: 55,
                            child: const Icon(
                              Icons.grade,
                              color: Colors.indigo,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 10,),
                          const Text(
                            'Total Grade: ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Montserrat'
                            ),
                          ),
                        ],
                      ),
                      Text(
                        ' ${widget.student!.totalGrade}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Montserrat'
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 170,
                  height: 60,
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
                    child: const Text(
                      'Log Out',
                      style: TextStyle(
                          color: Color(0xFFF40011),
                          fontSize: 16,
                          fontFamily: 'Montserrat'
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  width: 170,
                  height: 60,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.indigo.withOpacity(0.4)),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))))
                      ),
                      onPressed: (){
                        showDialog(
                            context: context,
                          builder: (BuildContext context){
                            return ChangePassword(student: student);
                          }
                        );
                      },
                      child: Text(
                        'Edit Password',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Montserrat'
                        ),
                      )
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

