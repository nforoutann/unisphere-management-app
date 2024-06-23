import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyScaffold extends StatelessWidget{
  MyScaffold({super.key, this.child});
  Widget? child;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'hello it is me',
          style: GoogleFonts.montserrat(),
        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 60,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xFF171717),
      body: child,
    );
  }
}

void main(){
  runApp(MaterialApp(
      theme: ThemeData(
    textTheme: GoogleFonts.quicksandTextTheme(),
  ),
      home:  MyScaffold(child: Text('helo'),)));
}