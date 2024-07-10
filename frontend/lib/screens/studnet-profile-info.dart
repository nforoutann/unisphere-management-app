import 'package:flutter/material.dart';
import 'package:frontend/network/network-helper.dart';
import 'package:frontend/objects/Student.dart'; // Assuming this is where Student class is imported from

class ProfileScreen extends StatelessWidget {
  final Student? student;

  ProfileScreen({this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(fontFamily: 'Montserrat', color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle,
              size: 100,
              color: Colors.white,
            ),
            Text(
              '${student!.name}',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 80, bottom: 100, right: 25, left: 25),
                decoration: BoxDecoration(
                  color: Color(0xFF171717),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Student ID: ${student!.id}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          Divider(color: Colors.black,),
                          Text(
                            'Current Term: ${student!.currentTerm}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          Divider(color: Colors.black,),
                          Text(
                            'Total Grade: ${student!.totalGrade}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          Divider(color: Colors.black,),
                          Text(
                            'Credits: ${student!.credits}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 80),
                    ElevatedButton(
                      onPressed: () {
                        // Show AlertDialog for changing info
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            String username = '';
                            String password = '';
                            String name = '';

                            return AlertDialog(
                              title: Text('Change Information'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    decoration: InputDecoration(labelText: 'Username'),
                                    onChanged: (value) {
                                      username = value;
                                    },
                                  ),
                                  TextField(
                                    decoration: InputDecoration(labelText: 'Password'),
                                    onChanged: (value) {
                                      password = value;
                                    },
                                  ),
                                  TextField(
                                    decoration: InputDecoration(labelText: 'Name'),
                                    onChanged: (value) {
                                      name = value;
                                    },
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Update Username'),
                                  onPressed: () {
                                    if(username.isNotEmpty)
                                      Network.changeUsername(student!.username, username);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Update Password'),
                                  onPressed: () {
                                    if(password.isNotEmpty)
                                      Network.changePassword(student!.username, password);

                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Update Name'),
                                  onPressed: () {
                                    if(name.isNotEmpty){
                                      Network.changeName(student!.username, name);
                                    }
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xffcb229d)),
                        fixedSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                      ),
                      child: Text("Change Info", style: TextStyle(color: Colors.white),),
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () {
                        // Show AlertDialog for confirmation to delete account
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete Account'),
                              content: Text('Are you sure you want to delete your account?'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Yes, delete'),
                                  onPressed: () {
                                    // Call delete account API or method
                                    Network.deleteStudent(student!.username); // Example method call
                                    Navigator.of(context).pop();
                                    // Navigate back or do other necessary actions after deletion
                                  },
                                ),
                                TextButton(
                                  child: Text('Close'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xffc31560)),
                        fixedSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                      ),
                      child: Text("Delete Account", style: TextStyle(color: Colors.white),),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
