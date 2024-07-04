import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:frontend/objects/Student.dart';

class Network{

  static Future<Student> getStudent(String username, String ipAddress) async {
    Completer<Student> completer = Completer<Student>();

    try {
      String command = 'POST: userInfo\$${username}\u0000';
      print('Sending command: $command');

      Socket socket = await Socket.connect(ipAddress, 8080);
      print('Connected to network');

      socket.write(command);

      // Listen for response from server
      socket.listen((List<int> data) {
        String jsonString = utf8.decode(data); // Convert received byte data to string
        Map<String, dynamic> jsonMap = jsonDecode(jsonString); // Parse JSON string to map

        Student student = Student.fromJson(jsonMap);

        socket.close(); // Properly close socket connection
        completer.complete(student); // Complete the future with the student object
      }, onError: (e) {
        print('Error receiving data from server: $e');
        completer.completeError(e); // Complete the future with an error
      });

    } catch (e) {
      print('Error connecting to network: $e');
      completer.completeError(e); // Complete the future with an error if connection fails
    }

    return completer.future;
  }

  static Future<String> login(String username, String password, String ipAddress) async {
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
  
}
