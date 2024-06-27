import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/objects/Student.dart';
import 'package:frontend/objects/Task.dart';
import 'package:frontend/screens/signup-screen.dart';
import 'package:frontend/screens/student-main-screen.dart';
import 'package:frontend/widgets/custom-scaffold.dart';
import 'package:frontend/widgets/login-signup-button.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'dart:io';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String ipAddress = "192.168.1.8";
  bool _isPasswordVisible = false;
  String response="";
  bool _usernameCheck=false;
  bool _passwordCheck=false;

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return CustomScaffold(
      child: Stack(
        children: [
          Transform.translate(
            offset: const Offset(0, -130),
            child: Image.asset(
              'assets/images/welcome.png',
              height: 310,
              width: 310,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 85),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                //color: Colors.black,
                color: Color(0xFF171717),
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: const Icon(
                          Icons.account_circle,
                          color: Colors.grey,
                        ),
                        label: Transform.translate(
                          offset: const Offset(0, -10),
                          child: const Text(
                            'username',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      style:const TextStyle(
                        color: Colors.white,
                      ),
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        label: Transform.translate(
                          offset: const Offset(0, -10),
                          child: const Text(
                            'password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // TODO: Implement forgot password functionality
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 17),
                    Transform.translate(
                      offset: Offset(0, 10),
                      child: MyElevatedButton(
                        onPressed: () async {
                          String result = await _login();
                          if(result == '200'){ //todo
                            createStudnet(_usernameController.text);
                            /*Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StudentMain()
                                ),
                            );*/
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    if (!isKeyboardOpen) ...[
                      const SizedBox(height: 80),
                      Transform.translate(
                        offset: Offset(0, 50),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Adjust the padding as needed
                                  //minimumSize: Size(0, 0), // Set the minimum size if needed todo
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce the tap target size
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUpScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _error(Color color, String myText){
    return DelightToastBar(
      builder: (context){
        return Align(
          alignment: Alignment.center,
          child: ToastCard(
            shadowColor: Colors.black45,
            leading: const Icon(
              Icons.notifications_active,
              color: Colors.white,
            ),
            color: color,
            title: Text(
              myText,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
      position: DelightSnackbarPosition.top,
      autoDismiss: true,
    ).show(
      context,
    );
  }

  Future<String> _login() async {
    String command="";
    command = 'GET: logInChecker\$${_usernameController.text}\$${_passwordController.text}\u0000';

    await Socket.connect(ipAddress, 8080).then((serverSocket) {
      serverSocket
          .write(command);
      serverSocket.flush();
      serverSocket.listen((socketResponse) {
        setState(() {
          response = String.fromCharCodes(socketResponse);
        });
      });
    });
    print("----------   server response is:  { $response }");

    if (response == "401") {
      _error(Color(0xffa8183e), 'Password is incorrect');
      _usernameCheck = true;
      _passwordCheck = false;
    } else if (response == "404") {
      _error(Color(0xffa8183e), 'Username not found, please create account first');
      _usernameCheck = false;
      _passwordCheck = false;
    } else if (response == "200") {
      _usernameCheck = true;
      _passwordCheck = true;
    }

    return response;
  }

  Future<Student> createStudnet(String username) async {
    String res = "";
    String name = "", email = "", currentTerm = "", strTasks = "", id = "";
    int credits = 0;
    double grade = 0;
    DateTime birthday = DateTime.now();
    bool hasBirthInfo = false;
    String command = "POST: userInfo\$${username}\u0000";
    print('Sending command: $command');

    // Create a completer to manage async response
    Completer<String> responseCompleter = Completer<String>();

    await Socket.connect(ipAddress, 8080).then((serverSocket) {
      print('Socket connected for createStudnet');
      serverSocket.write(command);
      serverSocket.flush();

      serverSocket.listen((socketResponse) {
        res = String.fromCharCodes(socketResponse);
        print('Received response: $res');
        responseCompleter.complete(res);
        serverSocket.destroy(); // Close the socket after receiving the response
      });
    }).catchError((e) {
      print('Socket error: $e');
      responseCompleter.completeError(e);
    });

    // Wait for the response to be completed
    res = await responseCompleter.future;

    List<String> resParts = res.split('\$');

    if (resParts.length >= 5) {
      name = resParts[0];
      id = resParts[1];
      currentTerm = resParts[2];
      email = resParts[3];

      String birth = resParts[4];
      if (birth.isNotEmpty) {
        birth = birth.substring(1, birth.length - 1);
        int year = int.parse(birth.split('-')[0]);
        int month = int.parse(birth.split('-')[1]);
        int day = int.parse(birth.split('-')[2]);
        birthday = DateTime(year, month, day);
        hasBirthInfo = true;
      }

      if (resParts.length > 5) {
        strTasks = resParts[5];
      }

      if (resParts.length > 6) {
        String strGrade = resParts[6];
        grade = double.parse(strGrade);
      }
    } else {
      // Handle the case where the response does not have enough parts
      print("Response does not have enough parts: $res");
    }

    Student student = Student(name, username);
    student.id = id;
    student.currentTerm = currentTerm;
    student.email = email;
    if (hasBirthInfo) {
      student.birthday = birthday;
    }
    student.grade = grade;
    if (strTasks.isNotEmpty) {
      List<String> Tasks = strTasks.split('//');
      for (int i = 0; i < Tasks.length; i++) {
        List<String> taskParts = Tasks[i].split('~');
        if (taskParts.length > 1) {
          String title = taskParts[0];
          bool done = taskParts[1] == 'yes';
          student.tasks.add(Task(title: title, done: done));
        }
      }
    }

    return student;
  }

}