import 'package:flutter/material.dart';

void main(){
  runApp(myApp());
}

class myApp extends StatelessWidget{
  const myApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar:  AppBar(
          backgroundColor: Colors.purple,
          title:const Text(
            'my app is running',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.yellow,
              width: 100,
              child: const Text("hello",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900
                ),
              ),
            ),
            const Text("bye",
              style: TextStyle(
                fontSize: 20
              ),
            )
          ],
        )
      ),

    );
  }
}