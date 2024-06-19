import 'package:flutter/material.dart';
import 'package:frontend/screens/welcome-screen.dart';
import 'package:frontend/screens/signup-screen-second.dart';

void main(){
  //runApp(myApp());
  runApp(thisApp());
}

class myApp extends StatelessWidget{
  myApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: welcomeScreen(),
    );
  }
}

class thisApp extends StatelessWidget{
  thisApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
    );
  }
}