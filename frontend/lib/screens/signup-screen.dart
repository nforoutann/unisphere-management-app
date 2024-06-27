import 'dart:io';

import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/login-screen.dart';
import 'package:frontend/widgets/custom-scaffold.dart';
import 'package:frontend/widgets/login-signup-button.dart';
import 'dart:io';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();

  bool _usernameCheck = false;
  bool _isPasswordVisible = false;
  int _selectedRoleIndex = 0;
  String response="";

  final List<String> _roles = ['Student', 'Teacher'];

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _idController.dispose();
    _departmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final bool isKeyboardOpen = keyboardHeight > 0;

    return CustomScaffold(
      child: Stack(
        children: [
          if (!isKeyboardOpen)
            Positioned(
              top: -133,
              left: 18,
              child: Image.asset(
                'assets/images/createAccount.png',
                width: 270,
                height: 295,
              ),
            ),
          Padding(
            padding: EdgeInsets.only(top: isKeyboardOpen ? 5 : 45), // Adjusted the padding to move the column higher
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
            padding: EdgeInsets.only(top: isKeyboardOpen ? 13 : 58), // Adjusted the padding to move the column higher
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Color(0xFF171717),
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19.0),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: keyboardHeight),
                  child: Transform.translate(
                    offset: Offset(0, -8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: isKeyboardOpen ? 30 : 70), // Adjusted the height to move the column higher
                        _buildSegmentedButton(),
                        const SizedBox(height: 20),
                        _buildTextField(_nameController, 'Name', Icons.account_circle),
                        const SizedBox(height: 10),
                        _buildTextField(_usernameController, 'Username', Icons.person),
                        const SizedBox(height: 10),
                        if (_selectedRoleIndex == 0)...{
                          _buildTextField(_idController, 'Student ID', Icons.school),
                        }else...{
                          _buildTextField(_idController, "Teacher's Code", Icons.vpn_key),
                          //todo check being unique
                        },
                        const SizedBox(height: 10),
                        _buildTextField(_emailController, 'Email', Icons.email),
                        const SizedBox(height: 10),
                        _buildPasswordField(_passwordController, 'Password'),
                        const SizedBox(height: 14),
                        MyElevatedButton(
                          onPressed: () async {
                            if(!_allFieldsFilled()){
                              _error(Color(0xffa8183e), "You have not filled all fields yet");
                            }else if(_passwordCheck(_passwordController.text) != 'done'){
                              String res = _passwordCheck(_passwordController.text);
                              _error(Color(0xffa8183e), res);
                            }else if(!_isIdNumber(_idController.text) && _selectedRoleIndex ==0){
                              _error(Color(0xffa8183e), 'The student id should consist only number');
                            }else if(!_isEmailValid(_emailController.text)){
                              _error(Color(0xffa8183e), 'Email is invalid');
                            }else if(_signUp() == '200'){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (e) => LoginScreen() //todo another screen
                                )
                              );
                            }
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 70), // Adjusted the height to move the column higher
                        if (!isKeyboardOpen)
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                    minimumSize: const Size(0, 0),
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (e) => const LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSegmentedButton() {
    return ToggleButtons(
      borderColor: Colors.indigo,
      fillColor: Colors.indigo,
      borderWidth: 2,
      selectedBorderColor: Colors.white,
      selectedColor: Colors.white,
      borderRadius: BorderRadius.circular(15),
      children: _roles.map((role) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(role, style: TextStyle(fontSize: 16,
            color: Colors.white,
          )),
        );
      }).toList(),
      onPressed: (int index) {
        setState(() {
          _selectedRoleIndex = index;
        });
      },
      isSelected: List.generate(_roles.length, (index) => _selectedRoleIndex == index),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return SizedBox(
      height: 60,
      child: TextField(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          border: const OutlineInputBorder(),
          suffixIcon: Icon(
            icon,
            color: Colors.grey,
            size: 24,
          ),
          labelText: label,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
            fontSize: 18,
          ),
        ),
        onChanged: (text) {
          print('Text in $label: $text'); // Add debug print to monitor text changes
        },
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String label) {
    return SizedBox(
      height: 60,
      child: TextField(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        controller: controller,
        obscureText: !_isPasswordVisible,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
              size: 24,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
          labelText: label,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
            fontSize: 18,
          ),
        ),
        onChanged: (text) {
          print('Text in $label: $text'); // Add debug print to monitor text changes
        },
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

  bool _allFieldsFilled(){
    bool nameFilled = _nameController.text.isNotEmpty;
    bool usernameFilled = _usernameController.text.isNotEmpty;
    bool idFilled = _idController.text.isNotEmpty;
    bool emailFilled = _emailController.text.isNotEmpty;
    bool passwordFilled = _passwordController.text.isNotEmpty;

    if(_selectedRoleIndex ==0){
      return nameFilled && usernameFilled && idFilled && emailFilled && passwordFilled;
    } else{
      return nameFilled && usernameFilled && emailFilled && passwordFilled;
    }
  }

  String _passwordCheck(String password){
    RegExp number = RegExp("[0-9]");
    RegExp lower = RegExp("[a-z]");
    RegExp upper = RegExp("[A-Z]");

    bool NumberOfCharacter = password.length >= 8;
    bool ConsistNumber = number.hasMatch(password);
    bool consistUpperLower = lower.hasMatch(password) && upper.hasMatch(password);
    if(NumberOfCharacter && ConsistNumber && consistUpperLower){
      return "done";
    } else if(!NumberOfCharacter){
      return "Password is invalid: The number of characters must be more than 8";
    } else if(!ConsistNumber){
      return "Password is invalid: The password must have numbers";
    } else if(!consistUpperLower){
      return "Password is invalid: The password must have upper case and lower letters";
    } else{
      return "error";
    }
  }

  bool _isEmailValid(String email){
    RegExp regExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regExp.hasMatch(email);
  }

  bool _isIdNumber(String id){
    RegExp regExp = RegExp(r'^([0-9]+)$');
    return regExp.hasMatch(id);
  }

  Future<String> _signUp() async {
    String command = "";
    if(_selectedRoleIndex == 0){
      command = 'GET: SignUpChecker\$student\$${_nameController.text}\$${_usernameController.text}\$${_idController.text}\$${_emailController.text}\$${_passwordController.text}\u0000';
    } else{
      command = 'GET: SignUpChecker\$teacher\$${_nameController.text}\$${_usernameController.text}\$${_emailController.text}\$${_passwordController.text}\u0000';
    }
    await Socket.connect("192.168.0.104", 8080).then((serverSocket) {
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

    if (response == "409") {
      //409 means conflict so the username is already used
      _usernameCheck = false;
    } else if (response == "200") {
      _usernameCheck = true;
    }
    return response;
  }
}