import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screen/screens/signup-screen.dart';
import 'package:screen/widgets/custom-scaffold.dart';
import 'package:screen/widgets/login-signup-button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return CustomScaffold(
      child: Stack(
        children: [
          Container(
            child: Transform.translate(
              offset: const Offset(0, -130),
              child: Image.asset(
                'assets/images/welcome.png',
                height: 310,
                width: 310,
              ),
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
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.check,
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
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.visibility_off,
                          color: Colors.grey,
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
                    const SizedBox(height: 40),
                    Transform.translate(
                      offset: Offset(0, 10),
                      child: MyElevatedButton(
                        onPressed: () {
                          // TODO: Implement login functionality
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

                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Adjust the padding as needed
                                  minimumSize: Size(0, 0), // Set the minimum size if needed
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
}
