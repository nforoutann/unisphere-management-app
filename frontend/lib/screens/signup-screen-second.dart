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
    final double keyboardHeight = MediaQuery
        .of(context)
        .viewInsets
        .bottom;
    final bool isKeyboardOpen = keyboardHeight > 0;

    return CustomScaffold(
      backgroundAddress: 'assets/images/blurBack.jpg',
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            height: double.infinity,
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}