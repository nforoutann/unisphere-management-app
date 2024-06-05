import 'package:flutter/material.dart';
import 'package:login/screens/login-screen.dart';
import 'package:login/screens/signup_screen.dart';
import 'package:login/widgets/custom-scaffold.dart';
import 'package:login/widgets/welcome-button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          SizedBox(
            width: 300.0, // Set the desired width
            height: 200.0,
            child: Image.asset(
              'assets/images/logo.png',
              height: 250.0, // Adjust the height as needed
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Flexible(
            flex: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 40.0,
              ),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      // Outlined text using Stack
                      WidgetSpan(
                        child: Stack(
                          children: [
                            // Outline text
                            Text(
                              'Welcome to unisphere!',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w700,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 6
                                  ..color = Color(0xFF1A237E), // Outline color
                              ),
                            ),
                            // Solid text
                            const Text(
                              'Welcome to unisphere!',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white, // Text color
                              ),
                            ),
                          ],
                        ),
                      ),
                      const TextSpan(
                        text: 'Where learning meets efficiency',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.w800
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'login',
                      onTap: LoginScreen(),
                      color: Colors.transparent,
                      textColor: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'sign up',
                      onTap: SignUpScreen(),
                      color: Colors.white,
                      textColor: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
