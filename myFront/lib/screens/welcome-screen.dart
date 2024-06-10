import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:screen/widgets/custom-scaffold.dart';
import 'package:screen/widgets/welcome-button.dart';

class welcomeScreen extends StatelessWidget{
  welcomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return CustomScaffold(
      child: Column(
        children: [
          Flexible(
            child: Transform.translate(
              offset: const Offset(-110.0, -80.0), // Adjust these values to move the photo
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcATop),
                child: SizedBox(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 100,
                    height: 200,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Transform.translate(
              offset: const Offset(50.0, -280.0), // Adjust these values to move the photo
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcATop),
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