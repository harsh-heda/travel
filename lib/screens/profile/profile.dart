import 'package:flutter/material.dart';
import 'package:travel/screens/profile/profile_screen.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        backgroundColor: Colors.lightBlueAccent[400],
      ),
      body: ProfileScreen(),
    );
  }
}
