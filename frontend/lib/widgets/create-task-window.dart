import 'package:flutter/material.dart';
import 'package:frontend/objects/Task.dart';
import 'package:frontend/widgets/login-signup-button.dart';
import 'package:frontend/widgets/messages.dart';
import 'package:frontend/widgets/time-picker/hour.dart';
import 'package:frontend/widgets/time-picker/minute.dart';

class CreateTaskWindow extends StatefulWidget {
  CreateTaskWindow({Key? key, required this.onClose, required this.onCreate, required this.tasks}) : super(key: key);

  final List<Task> tasks;
  final VoidCallback onClose;
  final Function(String, String, String) onCreate; // Callback with task data

  @override
  _CreateTaskWindowState createState() => _CreateTaskWindowState();
}

class _CreateTaskWindowState extends State<CreateTaskWindow> {
  final TextEditingController _titleController = TextEditingController();
  final FixedExtentScrollController _hourController = FixedExtentScrollController();
  final FixedExtentScrollController _minuteController = FixedExtentScrollController();
  String _selectedHour = '00';
  String _selectedMinute = '00';

  @override
  void initState() {
    super.initState();
    _hourController.addListener(_hourControllerListener);
    _minuteController.addListener(_minuteControllerListener);
  }

  @override
  void dispose() {
    _hourController.removeListener(_hourControllerListener);
    _minuteController.removeListener(_minuteControllerListener);
    super.dispose();
  }

  void _hourControllerListener() {
    setState(() {
      _selectedHour = _hourController.selectedItem.toString().padLeft(2, '0');
    });
  }

  void _minuteControllerListener() {
    setState(() {
      _selectedMinute = _minuteController.selectedItem.toString().padLeft(2, '0');
    });
  }

  String checkValid(){
    if(_titleController.text.isEmpty){
      return 'Please Enter The Title First';
    }
    for(int i=0 ; i<widget.tasks.length ; i++){
      if(widget.tasks[i].title == _titleController.text){
        return 'The Task Already Exist';
      }
    }
    return 'Done';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 25),
          const Padding(
            padding: EdgeInsets.only(),
            child: const Text(
              'Create Task',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Montserrat',
                fontStyle: FontStyle.italic,
                fontSize: 23,
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: const TextStyle(
                color: Colors.white,
              ),
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: const Icon(
                  Icons.bookmarks_sharp,
                  color: Colors.grey,
                ),
                labelText: 'New Task Title',
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                  fontSize: 17,
                  fontFamily: 'Montserrat',
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Align(
            child: Transform.translate(
              offset: Offset(30, -10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 70,
                    child: SizedBox(
                      height: 200,
                      child: ListWheelScrollView.useDelegate(
                        controller: _hourController,
                        itemExtent: 53,
                        perspective: 0.007,
                        diameterRatio: 1.2,
                        physics: FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedHour = index.toString().padLeft(2, '0');
                          });
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: 24,
                          builder: (context, index) {
                            return MyHour(
                              hours: index,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    ':',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40
                    ),
                  ),
                  SizedBox(width:8),
                  Container(
                    width: 70,
                    child: SizedBox(
                      height: 200,
                      child: ListWheelScrollView.useDelegate(
                        controller: _minuteController,
                        itemExtent: 53,
                        perspective: 0.007,
                        diameterRatio: 1.2,
                        physics: FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedMinute = index.toString().padLeft(2, '0');
                          });
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: 60,
                          builder: (context, index) {
                            return MyMinute(
                              mins: index,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(100, -150),
            child: Column(
              children: [
                MyElevatedButton(
                    width: 100,
                    onPressed: () {
                      String res = checkValid();
                      if(res == 'Done'){
                        widget.onCreate(
                          _titleController.text,
                          _selectedHour,
                          _selectedMinute,
                        );
                      } else{
                        Messages.error(context, Color(0xffa8183e), res);
                      }
                    },
                    child:const Text(
                      'Create',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat'
                      ),
                    )
                ),
                SizedBox(height: 15,),
                TextButton(
                  onPressed: widget.onClose,
                  child: const Text(
                    'Close',
                    style: TextStyle(
                        color: Colors.cyan,
                        fontFamily: 'Montserrat'
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}