import 'package:flutter/material.dart';
import 'package:frontend/network/network-helper.dart';
import 'package:frontend/objects/Student.dart';
import 'package:frontend/screens/signup-screen.dart';
import 'package:frontend/widgets/custom-scaffold.dart';
import 'package:frontend/widgets/login-signup-button.dart';
import 'package:frontend/screens/student-main-screen.dart';
import 'package:frontend/widgets/messages.dart';

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
    String fontFamilyName = 'Montserrat';

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
                          child: Text(
                            'username',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                              fontSize: 20,
                              fontFamily: fontFamilyName,
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
                          child: Text(
                            'password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                              fontSize: 20,
                              fontFamily: fontFamilyName,
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
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: fontFamilyName,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 17),
                    Transform.translate(
                      offset: Offset(0, 10),
                      child: MyElevatedButton(
                        onPressed: () async {
                          if(_usernameController.text.isEmpty || _passwordController.text.isEmpty){
                            Messages.error(context, Color(0xffa8183e), 'Please Fill All The Fields First');
                          } else{
                            String result = await Network.login(_usernameController.text, _passwordController.text);
                            if(result == '200'){
                              _usernameCheck = true;
                              _passwordCheck = true;
                              // todo createStudent(_usernameController.text, ipAddress);
                              String username = _usernameController.text; // Assuming _usernameController is a TextEditingController
                              Network.getStudent(username).then((student) {
                                // This code runs when student data is successfully fetched
                                print('Fetched student: ${student.name}');

                                // Navigate to the next screen with student data
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StudentMain(
                                      username: _usernameController.text,
                                      student: student,
                                    ),
                                  ),
                                );
                              }).catchError((error) {
                                // Handle error if student fetching fails
                                print('Error fetching student: $error');
                                if (error is String && error == '409') {
                                  Messages.error(context, Color(0xffa8183e), 'Password Is Incorrect');
                                  _usernameCheck = true; // Ensure _usernameCheck is properly handled in your code
                                }
                              });

                            } else if(result == '409'){
                              Messages.error(context ,Color(0xffa8183e), 'Password Is Incorrect');
                              _usernameCheck = true;
                              _passwordCheck = false;
                            } else if(result == "404"){
                              Messages.error(context ,Color(0xffa8183e), 'Username Not Found, Please Create Account First');
                              _usernameCheck = false;
                              _passwordCheck = false;
                            }
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Montserrat',
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
                               Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: fontFamilyName,
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
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: fontFamilyName,
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
}