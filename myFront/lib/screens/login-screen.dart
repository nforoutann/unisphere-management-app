import 'package:flutter/material.dart';
import 'package:screen/widgets/custom-scaffold.dart';

class LoginScreen extends StatefulWidget{
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  @override
  Widget build(BuildContext context){
    return CustomScaffold(child: child);
  }
}