import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final Gradient gradient;
  final VoidCallback? onPressed;
  final Widget child;
  double? width;
  double? height;


   MyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.gradient = const LinearGradient(
        colors: [
          Colors.cyan,
          Colors.indigo,
          Colors.cyan,
        ]
    ),
    this.height = 50,
    this.width = 350,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.black38,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: child,
      ),
    );
  }
}