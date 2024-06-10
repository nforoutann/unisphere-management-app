import 'package:flutter/material.dart';
import 'package:screen/widgets/custom-scaffold.dart';

class SignUpScreen extends StatefulWidget{
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>{
  @override
  Widget build(BuildContext context){
    return CustomScaffold(child: child);
  }
}