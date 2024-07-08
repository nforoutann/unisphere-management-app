import 'package:flutter/material.dart';
import 'package:frontend/network/network-helper.dart';
import 'package:frontend/objects/Task.dart';
import 'package:frontend/widgets/create-task-window.dart';
import 'package:frontend/widgets/done-task-card.dart';
import 'package:frontend/widgets/to-do-card.dart';

class ToDoScreen extends StatefulWidget {
  final List<Task> tasks;
  final String username;

  ToDoScreen({Key? key, required this.tasks, required this.username}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  List<Task> ongoingTasks = [];
  List<Task> doneTasks = [];
  bool _isCreatingTask = false; // Track whether creating task popup is shown

  @override
  void initState() {
    super.initState();
    ongoingTasks = widget.tasks.where((task) => !task.done).toList();
    doneTasks = widget.tasks.where((task) => task.done).toList();
  }

  void addTask(String title, String hour, String minute) {
    DateTime now = DateTime.now();
    DateTime time = DateTime(now.year, now.month, now.day, int.parse(hour), int.parse(minute));
    Task newTask = Task(
      title: title,
      time: time,
      done: false, // Assuming new tasks are initially not done
    );
    String timeStr = '{${time.year}::${time.month}::${time.day}::${time.hour}::${time.minute}}';
    Network.creatTask(widget.username, title,timeStr , false);
    setState(() {
      ongoingTasks.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 50),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: ongoingTasks.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 4),
                      child: ToDoCard(
                        onDone: () {
                          setState(() {
                            ongoingTasks[index].done = true;
                            doneTasks.add(ongoingTasks[index]);
                            ongoingTasks.removeAt(index);
                          });
                        },
                        username: widget.username,
                        task: ongoingTasks[index],
                        onDelete: () {
                          setState(() {
                            ongoingTasks.removeAt(index);
                          });
                        },
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(left: 1, right: 1),
                            child: Text(
                              ongoingTasks[index].title,
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      '${widget.tasks.length == 0 ? 'No Tasks Yet' : 'Done Tasks'}',
                      style:const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontStyle: FontStyle.italic,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: doneTasks.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 4),
                      child: DoneTaskCard(
                        username: widget.username,
                        task: doneTasks[index],
                        onDelete: () {
                          setState(() {
                            doneTasks.removeAt(index);
                          });
                        },
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(left: 1, right: 1),
                            child: Text(
                              doneTasks[index].title,
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 80), // Adjust height as needed for FloatingActionButton clearance
              ],
            ),
          ),
          if (_isCreatingTask)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isCreatingTask = false;
                  });
                },
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          if (_isCreatingTask)
            Padding(
              padding: EdgeInsets.only(bottom: 200),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 1.0, end: 0.0),
                duration: Duration(milliseconds: 300),
                builder: (context, value, child) {
                  // Calculate half of screen height
                  final screenHeight = MediaQuery.of(context).size.height;
                  final containerHeight = screenHeight / 2;

                  return Transform.translate(
                    offset: Offset(0, 230), // Slide up from the bottom
                    child: Container(
                      height: containerHeight,
                      child: Stack(
                        children: [
                          Container(
                            height: containerHeight + 80, // Ensure the height covers the screen
                            margin: EdgeInsets.only(top: 45),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                          ),
                          Container(
                            height: containerHeight + 80,
                            margin: const EdgeInsets.only(top: 60, bottom: 0), // Adjust the top margin to reveal the white background
                            decoration: const BoxDecoration(
                              color: Color(0xFF171717),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: CreateTaskWindow(
                              tasks: widget.tasks,
                              onCreate: (title, hour, minute) {
                                addTask(title, hour, minute); // Add task to ongoingTasks
                                setState(() {
                                  _isCreatingTask = false;
                                });
                              },
                              onClose: () {
                                setState(() {
                                  _isCreatingTask = false;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          if (!_isCreatingTask) // Only show FAB when not creating task
            Align(
              alignment: Alignment(0.85, 1.1),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _isCreatingTask = true;
                      });
                    },
                    backgroundColor: Colors.indigoAccent,
                    elevation: 4.0,
                    shape: CircleBorder(),
                    child:const Icon(
                      Icons.add,
                      size: 37,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}