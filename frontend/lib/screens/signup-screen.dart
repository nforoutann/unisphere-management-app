import 'package:flutter/material.dart';
import 'package:frontend/screens/login-screen.dart';
import 'package:frontend/widgets/custom-scaffold.dart';
import 'package:frontend/widgets/login-signup-button.dart';

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

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _idController.dispose();
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
              top: -127,
              left: 18,
              child: Image.asset(
                'assets/images/createAccount.png',
                width: 270,
                height: 295,
              ),
            ),
          Padding(
            padding: EdgeInsets.only(top: isKeyboardOpen ? 0 : 60),
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
            padding: EdgeInsets.only(top: isKeyboardOpen ? 8 : 73),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: isKeyboardOpen ? 30 : 90),
                      _buildTextField(_nameController, 'Name', Icons.account_circle),
                      const SizedBox(height: 10),
                      _buildTextField(_usernameController, 'Username', Icons.person),
                      const SizedBox(height: 10),
                      _buildTextField(_idController, 'Student ID', Icons.school),
                      const SizedBox(height: 10),
                      _buildTextField(_emailController, 'Email', Icons.email),
                      const SizedBox(height: 10),
                      _buildPasswordField(_passwordController, 'Password'),
                      const SizedBox(height: 14),
                      MyElevatedButton(
                        onPressed: () {
                          // TODO: Implement sign-up functionality
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 90),
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
          )
        ],
      ),
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
}
