import 'package:flutter/material.dart';
import 'package:frontend/widgets/custom-scaffold.dart';
import 'package:frontend/widgets/welcome-button.dart';
import 'package:frontend/screens/signup-screen.dart';
import 'package:frontend/screens/login-screen.dart';

class welcomeScreen extends StatelessWidget{
  welcomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return CustomScaffold(
      child: Column(
        children: [
          Expanded(
            child: Transform.translate(
              offset: const Offset(-75.0, -80.0), // Adjust these values to move the photo
              child: ColorFiltered(
                colorFilter:const ColorFilter.mode(Colors.black, BlendMode.srcATop),
                child: SizedBox(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: width*0.29,
                    height: height*0.25,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Transform.translate(
              offset: const Offset(88.0, -280.0), // Adjust these values to move the photo
              child: ColorFiltered(
                colorFilter:const ColorFilter.mode(Colors.black, BlendMode.srcATop),
                child: SizedBox (
                  height: height*0.5,
                  width: width*0.55,
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
                  height: height*0.5,
                  width: width*0.8,
                  child: Image.asset(
                    'assets/images/hello.png',
                  ),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(95, 10),
            child: WelcomeButton(
              buttonText: 'Sign Up',
              onTap:const SignUpScreen(),
              color: Colors.cyan,
              textColor: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Transform.translate(
            offset: Offset(95, 10),
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