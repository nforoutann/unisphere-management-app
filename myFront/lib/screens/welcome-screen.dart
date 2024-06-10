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
              offset: const Offset(-20.0, -300.0), // Adjust these values to move the photo
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcATop),
                child: SizedBox(
                  height: 100,
                  width: 300,
                  child: Image.asset(
                    'assets/images/logoWritten.png',
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}