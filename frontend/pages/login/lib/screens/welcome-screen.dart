import 'package:flutter/material.dart';
import 'package:login/widgets/custom-scaffold.dart';

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
                        text: 'Manage your tasks in the easiest way you can!',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Text('welcome'),
          ),
        ],
      ),
    );
  }
}
