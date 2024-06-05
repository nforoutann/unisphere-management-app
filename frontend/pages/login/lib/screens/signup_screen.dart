import 'package:flutter/material.dart';
import 'package:login/widgets/custom-scaffold.dart';

class SignUpScreen extends StatefulWidget{
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>{
  @override
  Widget build(BuildContext context){
    return const CustomScaffold(
      child: Text('Sign up'),
    );
  }
}
