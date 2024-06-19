import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget{
  CustomScaffold({super.key,required this.child, this.backgroundAddress='assets/images/background.jpg'});
  Widget child;
  String? backgroundAddress;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            backgroundAddress!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(child: this.child),
        ],
      ),
    );
  }
}