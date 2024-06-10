import 'package:flutter/material.dart';
import 'package:screen/widgets/custom-scaffold.dart';

class welcomeScreen extends StatelessWidget{
  welcomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return CustomScaffold(
      child: Column(
        children: [
          Expanded(
            child: Transform.translate(
              offset: const Offset(-60.0, -140.0), // Adjust these values to move the photo
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
              offset: const Offset(100.0, -600.0), // Adjust these values to move the photo
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcATop),
                child: SizedBox(
                  width: 300,
                  child: Image.asset(
                    'assets/images/unisphere.png',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}