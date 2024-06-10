import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget{
  WelcomeButton({super.key, this.textColor, this.buttonText, this.color});
  //Widget? onTap;
  Color? color;
  String? buttonText;
  Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 300,
        height: 30,
        margin: EdgeInsets.symmetric(vertical: 10),
        // Adds spacing between buttons
        decoration: BoxDecoration(
          color: color ?? Colors.grey, // Updated color to match the image
          borderRadius: BorderRadius.circular(30), // More rounded corners
        ),
        alignment: Alignment.center,
        child: Text(
          buttonText ?? 'Button',
          style: TextStyle(
            color: textColor ?? Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}