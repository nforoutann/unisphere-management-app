import 'package:flutter/material.dart';
import '../widgets/custom-scaffold.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'User Information',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 25),
            const ListTile(
              title: Text('Username', style: TextStyle(color: Colors.white)),
              subtitle: Text('user123', style: TextStyle(color: Colors.white)),
            ),
            const ListTile(
              title: Text('Email', style: TextStyle(color: Colors.white)),
              subtitle: Text('user@example.com', style: TextStyle(color: Colors.white)),
            ),
            const ListTile(
              title: Text('Password', style: TextStyle(color: Colors.white)),
              subtitle: Text('*********', style: TextStyle(color: Colors.white)), // Placeholder for password
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                //todo
              },
              child: Text('Edit Profile'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                //todo
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              child: Text('Delete Account'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProfileScreen(),
      )
  );
}
