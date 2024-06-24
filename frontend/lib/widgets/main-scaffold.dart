import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget{
  MyScaffold({super.key, required this.child, this.navigationBar});
  late Widget child;
  Widget? navigationBar;
  Color backgroundColor = Color(0xFF171717);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: navigationBar,
      appBar: AppBar(
        title: Text(
          'hello it is me',

        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontFamily: 'Montserrat',
          fontStyle: FontStyle.italic,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: backgroundColor,
      body: child,
    );
  }
}