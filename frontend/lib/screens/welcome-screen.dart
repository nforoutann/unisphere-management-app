import 'package:flutter/material.dart';
import 'package:frontend/widgets/custom-scaffold.dart';
import 'package:frontend/widgets/welcome-button.dart';
import 'package:frontend/screens/signup-screen.dart';
import 'package:frontend/screens/login-screen.dart';

class welcomeScreen extends StatelessWidget{
  welcomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return CustomScaffold(
      child: Column(
        children: [
          Expanded(
            child: Transform.translate(
              offset: const Offset(-85.0, -80.0), // Adjust these values to move the photo
              child: ColorFiltered(
                colorFilter:const ColorFilter.mode(Colors.black, BlendMode.srcATop),
                child: SizedBox(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 120,
                    height: 200,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Transform.translate(
              offset: const Offset(75.0, -280.0), // Adjust these values to move the photo
              child: ColorFiltered(
                colorFilter:const ColorFilter.mode(Colors.black, BlendMode.srcATop),
                child: SizedBox (
                  height: 230,
                  width: 230,
                  child: Image.asset(
                    'assets/images/unisphere.png',
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Transform.translate(
              offset: const Offset(-65.0, -330.0), // Adjust these values to move the photo
              child: ColorFiltered(
                colorFilter:const ColorFilter.mode(Colors.black, BlendMode.srcATop),
                child: SizedBox(
                  height: 400,
                  width: 350,
                  child: Image.asset(
                    'assets/images/hello.png',
                  ),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(80, 0),
            child: WelcomeButton(
              buttonText: 'Sign Up',
              onTap:const SignUpScreen(),
              color: Colors.cyan,
              textColor: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Transform.translate(
            offset: Offset(80, 0),
            child: WelcomeButton(
              buttonText: 'Login',
              onTap:const LoginScreen(),
              color: Colors.indigoAccent,
              textColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}