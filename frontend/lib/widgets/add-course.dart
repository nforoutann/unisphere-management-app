import 'package:flutter/material.dart';
import 'package:frontend/network/network-helper.dart';
import 'package:frontend/widgets/login-signup-button.dart';
import 'package:frontend/widgets/messages.dart';



class AddCourse extends StatefulWidget {

  final VoidCallback onClose;
  String? username;


  AddCourse({required this.onClose, required this.username});

  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  TextEditingController _courseController = TextEditingController();

  @override
  void dispose() {
    _courseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Padding(
      padding: EdgeInsets.only(top: isKeyboardOpen ? 30 : 90, right: 20, left: 20),
      child: Center(
        child: Column(
          children: [
            Text(
              'Add Course',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              style: const TextStyle(
                color: Colors.white,
              ),
              controller: _courseController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: const Icon(
                  Icons.bookmarks_sharp,
                  color: Colors.grey,
                ),
                labelText: "New Course's code",
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                  fontSize: 17,
                  fontFamily: 'Montserrat',
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(height: 60),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyElevatedButton(
                    width: 100,
                    onPressed: () {
                      if(_courseController.text.isEmpty){
                        Messages.error(context, Color(0xffa8183e), "Please Enter The Code first");
                      }else{
                        Network.addStudentToCourse(widget.username!, _courseController.text)
                            .then((value) {
                          String res = value;
                          if(res != "200"){
                            String message = "ERROR";
                            if(res == "404"){
                              message = "Course Not Found";
                            }else if(res == "409"){
                              message = "Student Already Has The Course";
                            }
                            Messages.error(context, Color(0xffa8183e), message);
                          }
                          print('Result: $res');
                        })
                            .catchError((error) {
                          print('Error: $error');
                        });
                      }
                    },
                    child:const Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // Add some space between the buttons
                  TextButton(
                    onPressed: widget.onClose,
                    child: Text(
                      'Close',
                      style: TextStyle(
                        color: Colors.cyan,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
