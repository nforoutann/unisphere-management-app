import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget{
  WelcomeButton({super.key, this.textColor, this.buttonText, this.color});
  //Widget? onTap;
  Color? color;
  String? buttonText;
  Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(-15, -100),
      child:  SizedBox(
        height: 60,
        width: 300, // Set a fixed width for the button
        child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color!),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            shadowColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
          child: Text(
            buttonText!,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 23,
              color: textColor!,
            ),
          ),
        ),
      ),
    );
  }
}