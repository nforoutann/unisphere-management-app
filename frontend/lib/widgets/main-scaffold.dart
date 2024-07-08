import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget{
  MyScaffold({super.key, this.child, this.navigationBar, required this.text, this.firstButton, this.secondButton});
  Widget? child;
  Widget? navigationBar;
  Color backgroundColor = Color(0xFF171717);
  String? text;
  Widget? firstButton;
  Widget? secondButton;


  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: navigationBar,
      appBar: AppBar(
        title: Text(
            this.text!,
          style: const TextStyle(
            fontSize: 30,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: Align(
          alignment: Alignment(1, 0),
          child: IconButton(
            icon: Icon(Icons.account_circle),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.indigoAccent),
            ),
            onPressed: () {
              //todo
            },
          ),
        ),
        titleTextStyle:const TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontFamily: 'Montserrat',
          fontStyle: FontStyle.italic,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: backgroundColor,
        elevation: 0,
        actions: [
          if(firstButton!=null) firstButton!,
          if(secondButton!=null) Padding(padding: EdgeInsets.only(right: 15) ,child: secondButton!),
        ],
      ),
      backgroundColor: backgroundColor,
      body: child,
    );
  }
}