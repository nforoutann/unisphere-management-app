import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyScreen(),
    );
  }
}

class MyScreen extends StatelessWidget {
  // Sample data for the list
  final List<String> dataList = ['x', 'y', 'z', 't', 'n', 'a', 'b', 'c', 'q'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom List View'),
      ),
      body: Column(
        children: [
          // First part that is always visible
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.blueAccent,
            child: Text(
              'Fixed Part',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
          // Second part containing the custom list
          Expanded(
            child: ListView.builder(
              itemCount: (dataList.length / 2).ceil(), // Calculate number of rows needed
              itemBuilder: (context, index) {
                int firstIndex = index * 2;
                int secondIndex = index * 2 + 1;

                // Check if secondIndex is within bounds
                if (secondIndex < dataList.length) {
                  // Display two items in a row
                  return Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              dataList[firstIndex],
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0), // Add spacing between cards
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              dataList[secondIndex],
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  // Display single item in a row
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        dataList[firstIndex],
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
