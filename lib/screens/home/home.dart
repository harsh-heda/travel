import 'package:flutter/material.dart';
import 'package:travel/screens/home/travelPost_form.dart';
import 'package:travel/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showAddPostPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: TravelPostForm(),
            );
          });
    }

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Travel Buddy'),
        backgroundColor: Colors.blue[400],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle_sharp),
            iconSize: 40,
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPostPanel(),
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
