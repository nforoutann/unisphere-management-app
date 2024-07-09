import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:frontend/objects/Assignment.dart';
import 'package:frontend/objects/Course.dart';
import 'package:frontend/objects/Student.dart';
import 'package:frontend/objects/Task.dart';
import 'package:frontend/widgets/messages.dart';

class Network {
  static String ipAddress = "192.168.1.8";

  static Future<Student> getStudent(String username) async {
    Completer<Student> completer = Completer<Student>();
    DateTime now = DateTime.now();
    String today = '{${now.year}::${now.month}::${now.day}::${now.hour}::${now.minute}}';
    try {
      String command = 'GET: userInfo\$${username}\$${today}\u0000';
      print('Sending command: $command');

      Socket socket = await Socket.connect(ipAddress, 8080);
      print('Connected to network');

      socket.write(command);

      // Listen for response from server
      socket.listen((List<int> data) {
        String jsonString = utf8.decode(
            data); // Convert received byte data to string
        Map<String, dynamic> jsonMap = jsonDecode(
            jsonString); // Parse JSON string to map

        Student student = Student.fromJson(jsonMap);

        socket.close(); // Properly close socket connection
        completer.complete(
            student); // Complete the future with the student object
      }, onError: (e) {
        print('Error receiving data from server: $e');
        completer.completeError(e); // Complete the future with an error
      });
    } catch (e) {
      print('Error connecting to network: $e');
      completer.completeError(
          e); // Complete the future with an error if connection fails
    }

    return completer.future;
  }

  static Future<String> login(String username, String password) async {
    String command = 'GET: logInChecker\$${username}\$${password}\u0000';
    String response = ""; // Clear previous response
    Completer<String> responseCompleter = Completer<String>();

    await Socket.connect(ipAddress, 8080).then((serverSocket) {
      serverSocket.write(command);
      serverSocket.flush();
      serverSocket.listen((socketResponse) {
        response = String.fromCharCodes(socketResponse);
        responseCompleter.complete(response);
        serverSocket.destroy(); // Close the socket after receiving the response
      }, onDone: () {
        if (!responseCompleter.isCompleted) {
          responseCompleter.completeError("Socket closed without response");
        }
      }, onError: (error) {
        responseCompleter.completeError(error);
      });
    }).catchError((error) {
      responseCompleter.completeError(error);
    });

    try {
      response = await responseCompleter.future;
    } catch (e) {
      print("Error receiving response: $e");
      return "error";
    }

    print("----------   network response is:  { $response }");


    return response;
  }

  static Future<void> editTask(String type, String username, String title, bool done) async {
    String command = 'POST: ${type}\$${username}\$${title}\$${done
        ? "yes"
        : "no"}\u0000';
    String response = "";
    Completer<String> responseCompleter = Completer<String>();

    await Socket.connect(ipAddress, 8080).then((serverSocket) {
      serverSocket.write(command);
      serverSocket.flush();
      serverSocket.listen((socketResponse) {
        response = String.fromCharCodes(socketResponse);
        responseCompleter.complete(response);
        serverSocket.destroy(); // Close the socket after receiving the response
      }, onDone: () {
        if (!responseCompleter.isCompleted) {
          responseCompleter.completeError("Socket closed without response");
        }
      }, onError: (error) {
        responseCompleter.completeError(error);
      });
    }).catchError((error) {
      responseCompleter.completeError(error);
    });

    try {
      response = await responseCompleter.future;
    } catch (e) {
      print("Error receiving response: $e");
    }
    print("----------   network response is:  { $response }");
  }

  static Future<List<Task>> getTasks(String username) async {
    Completer<List<Task>> completer = Completer<List<Task>>();

    try {
      String command = 'GET: getTasks\$${username}\u0000';
      print('Sending command: $command');

      Socket socket = await Socket.connect(ipAddress,
          8080); // Replace 'your_server_ip_address' with the actual IP address
      print('Connected to network');

      socket.write(command);

      // Listen for response from server
      socket.listen((List<int> data) {
        try {
          String jsonString = utf8.decode(
              data); // Convert received byte data to string
          List<dynamic> jsonList = jsonDecode(
              jsonString); // Parse JSON string to list

          // Parse each item in the list as a Task
          List<Task> tasks = jsonList.map((json) => Task.fromJson(json))
              .toList();

          socket.close(); // Properly close socket connection
          completer.complete(
              tasks); // Complete the future with the list of tasks
        } catch (e) {
          print('Error parsing data from server: $e');
          completer.completeError(e); // Complete the future with an error
        }
      }, onError: (e) {
        print('Error receiving data from server: $e');
        completer.completeError(e); // Complete the future with an error
      });
    } catch (e) {
      print('Error connecting to network: $e');
      completer.completeError(
          e); // Complete the future with an error if connection fails
    }

    return completer.future;
  }

  static Future<void> createTask(String username, String title, String time, bool done) async {
    String command = 'POST: createTask\$${username}\$${title}\$${time}\$${done
        ? "yes"
        : "no"}\u0000';
    String response = "";
    Completer<String> responseCompleter = Completer<String>();

    await Socket.connect(ipAddress, 8080).then((serverSocket) {
      serverSocket.write(command);
      serverSocket.flush();
      serverSocket.listen((socketResponse) {
        response = String.fromCharCodes(socketResponse);
        responseCompleter.complete(response);
        serverSocket.destroy(); // Close the socket after receiving the response
      }, onDone: () {
        if (!responseCompleter.isCompleted) {
          responseCompleter.completeError("Socket closed without response");
        }
      }, onError: (error) {
        responseCompleter.completeError(error);
      });
    }).catchError((error) {
      responseCompleter.completeError(error);
    });

    try {
      response = await responseCompleter.future;
    } catch (e) {
      print("Error receiving response: $e");
    }
    print("----------   network response is:  { $response }");
  }

  static Future<List<Course>> getCourses(String username) async {
    Completer<List<Course>> completer = Completer<List<Course>>();

    try {
      String command = 'GET: getCourses\$${username}\u0000';
      print('Sending command: $command');

      Socket socket = await Socket.connect(ipAddress, 8080); // Replace 'your_server_ip_address' with the actual IP address
      print('Connected to network');

      socket.write(command);

      // Listen for response from server
      socket.listen((List<int> data) {
        try {
          String jsonString = utf8.decode(
              data); // Convert received byte data to string
          List<dynamic> jsonList = jsonDecode(
              jsonString); // Parse JSON string to list

          // Parse each item in the list as a Task
          List<Course> courses = jsonList.map((json) => Course.fromJson(json))
              .toList();

          socket.close(); // Properly close socket connection
          completer.complete(
              courses); // Complete the future with the list of tasks
        } catch (e) {
          print('Error parsing data from server: $e');
          completer.completeError(e); // Complete the future with an error
        }
      }, onError: (e) {
        print('Error receiving data from server: $e');
        completer.completeError(e); // Complete the future with an error
      });
    } catch (e) {
      print('Error connecting to network: $e');
      completer.completeError(
          e); // Complete the future with an error if connection fails
    }

    return completer.future;
  }

  static Future<String> addStudentToCourse(String username, String courseCode) async{
    String command = 'POST: addStudentToCourse\$${username}\$${courseCode}\u0000';
    String response = "";
    Completer<String> responseCompleter = Completer<String>();

    await Socket.connect(ipAddress, 8080).then((serverSocket) {
      serverSocket.write(command);
      serverSocket.flush();
      serverSocket.listen((socketResponse) {
        response = String.fromCharCodes(socketResponse);
        responseCompleter.complete(response);
        serverSocket.destroy(); // Close the socket after receiving the response
      }, onDone: () {
        if (!responseCompleter.isCompleted) {
          responseCompleter.completeError("Socket closed without response");
        }
      }, onError: (error) {
        responseCompleter.completeError(error);
      });
    }).catchError((error) {
      responseCompleter.completeError(error);
    });

    try {
      response = await responseCompleter.future;
    } catch (e) {
      print("Error receiving response: $e");
    }
    print("----------   network response is:  { $response }");

    return responseCompleter.future;
  }

  static Future<List<Assignment>> getAssignments(String username) async{
    Completer<List<Assignment>> completer = Completer<List<Assignment>>();
    DateTime now = DateTime.now();
    String today = '{${now.year}::${now.month}::${now.day}::${now.hour}::${now.minute}}';

    try {
      String command = 'GET: getAssignments\$${username}\$${today}\u0000';
      print('Sending command: $command');

      Socket socket = await Socket.connect(ipAddress,
          8080); // Replace 'your_server_ip_address' with the actual IP address
      print('Connected to network');

      socket.write(command);

      // Listen for response from server
      socket.listen((List<int> data) {
        try {
          String jsonString = utf8.decode(
              data); // Convert received byte data to string
          List<dynamic> jsonList = jsonDecode(
              jsonString); // Parse JSON string to list

          // Parse each item in the list as a Task
          List<Assignment> assignments = jsonList.map((json) => Assignment.fromJson(json))
              .toList();

          socket.close(); // Properly close socket connection
          completer.complete(assignments); // Complete the future with the list of tasks
        } catch (e) {
          print('Error parsing data from server: $e');
          completer.completeError(e); // Complete the future with an error
        }
      }, onError: (e) {
        print('Error receiving data from server: $e');
        completer.completeError(e); // Complete the future with an error
      });
    } catch (e) {
      print('Error connecting to network: $e');
      completer.completeError(
          e); // Complete the future with an error if connection fails
    }

    return completer.future;
  }

  static Future<void> editAssignment(String username, String assignmentId, String estimatedTime, String description, bool uploaded) async {
    print('hello');
    String command = 'POST: editAssignment\$${username}\$${assignmentId}\$${estimatedTime}\$${description}\$${uploaded ? "yes" : "no"}\u0000';
    String response = "";
    Completer<String> responseCompleter = Completer<String>();
    print(command);

    try {
      final serverSocket = await Socket.connect(ipAddress, 8080);
      // Write the command to the server
      serverSocket.write(command);
      await serverSocket.flush();

      // Listen for server responses
      serverSocket.listen(
              (socketResponse) {
            response = String.fromCharCodes(socketResponse);
            responseCompleter.complete(response);
            serverSocket.destroy(); // Close the socket after receiving the response
          },
          onDone: () {
            if (!responseCompleter.isCompleted) {
              responseCompleter.completeError("Socket closed without response");
            }
          },
          onError: (error) {
            if (!responseCompleter.isCompleted) {
              responseCompleter.completeError(error);
            }
          }
      );

      response = await responseCompleter.future;
    } catch (e) {
      print("Error receiving response: $e");
      return;
    }

    print("----------   network response is:  { $response }");
  }


}