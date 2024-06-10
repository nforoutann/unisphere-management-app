import 'package:flutter/material.dart';
import 'package:screen/widgets/custom-scaffold.dart';
import 'package:screen/widgets/welcome-button.dart';

class welcomeScreen extends StatelessWidget{
  welcomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return CustomScaffold(
      child: Column(
        children: [
          Expanded(
            child: Transform.translate(
              offset: const Offset(-90.0, -40.0), // Adjust these values to move the photo
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcATop),
                child: SizedBox(
                  width: 400,
                  height: 400,
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 400,
                    width: 400,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Transform.translate(
              offset: const Offset(20.0, -300.0), // Adjust these values to move the photo
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcATop),
                child: SizedBox (
                  height: 400,
                  width: 700,
                  child: Image.asset(
                    'assets/images/unisphere.png',
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Transform.translate(
              offset: const Offset(-100.0, -330.0), // Adjust these values to move the photo
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcATop),
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
          Flexible(
            flex: 0,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  WelcomeButton(
                    buttonText: 'Sign Up',
                    //onTap: SignUpScreen(),
                    color: Colors.blue,
                    textColor: Colors.black,
                  ),
                  SizedBox(height: 16),
                  WelcomeButton(
                    buttonText: 'Login',
                    //onTap: LoginScreen(),
                    color: Colors.indigoAccent,
                    textColor: Colors.black,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}