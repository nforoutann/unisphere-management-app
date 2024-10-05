import 'package:flutter/material.dart';
import 'package:frontend/network/network-helper.dart';
import 'package:frontend/objects/Student.dart';
import 'package:frontend/widgets/login-signup-button.dart';
import 'package:frontend/widgets/messages.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key, required this.student});
  Student student;
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 400,
        width: 350,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6))
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFF171717),
            borderRadius: BorderRadius.all(Radius.circular(4))
          ),
          child: Column(
            children: [
              Text(
                'Change Password',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  fontSize: 20
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: oldPassword,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat'
                ),
                decoration: InputDecoration(
                  labelText: 'Old Password',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat'
                  )
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: newPassword,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat'
                ),
                decoration: InputDecoration(
                    labelText: 'New Password',
                    labelStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                    ),
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: confirmPassword,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat'
                ),
                decoration: InputDecoration(
                    labelText: 'Confirm New Password',
                    labelStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat'
                    )
                ),
              ),
              SizedBox(height: 30,),
              MyElevatedButton(
                width: 150,
                  onPressed: () async {
                    if(oldPassword.text != student.password && oldPassword.text.isNotEmpty){
                      Messages.error(context, Color(0xffa8183e), 'Your Password Does Not Match');
                    } else if(newPassword.text != confirmPassword.text || newPassword.text.isEmpty || confirmPassword.text.isEmpty){
                      Messages.error(context, Color(0xffa8183e), 'Invalid Amount!!');
                    } else{
                      await Network.changePassword(student.username, newPassword.text);
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Apply',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat'
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 //todo check the validity and conditions of a good new password