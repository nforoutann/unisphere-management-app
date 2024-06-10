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
              offset: const Offset(-40.0, -78.0), // Adjust these values to move the photo
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcATop),
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: Image.asset(
                    'assets/images/logo.png',
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Transform.translate(
              offset: const Offset(100.0, -390.0), // Adjust these values to move the photo
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcATop),
                child: Container  (
                  width: 300,
                  child: Image.asset(
                    'assets/images/unisphere.png',
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Transform.translate(
              offset: const Offset(-40.0, -480.0), // Adjust these values to move the photo
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcATop),
                child: SizedBox(
                  height: 200,
                  width: 300,
                  child: Image.asset(
                    'assets/images/hello.png',
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 8,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Column(
                children: [
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign Up',
                      //onTap: SignUpScreen(),
                      color: Colors.blue,
                      textColor: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'Login',
                      //onTap: LoginScreen(),
                      color: Colors.indigoAccent,
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}