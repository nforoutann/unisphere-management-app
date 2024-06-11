import 'package:flutter/material.dart';
import 'package:screen/screens/welcome-screen.dart';

void main(){
  runApp(myApp());
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