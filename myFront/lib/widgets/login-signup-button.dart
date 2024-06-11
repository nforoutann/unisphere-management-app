import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final Gradient gradient;
  final VoidCallback? onPressed;
  final Widget child;

  const MyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.gradient = const LinearGradient(colors: [Colors.cyan, Colors.indigo]),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 50,
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