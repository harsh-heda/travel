import 'package:flutter/material.dart';
import 'package:travel/screens/home/travelPost_form.dart';
import 'package:travel/services/auth.dart';
import 'package:travel/services/database.dart';
import 'package:travel/models/posts.dart';
import 'package:provider/provider.dart';
import 'package:travel/screens/home/post_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  //final DatabaseService _data = DatabaseService();

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

    return StreamProvider<List<PostData>>.value(
      value: DatabaseService().postData,
      child: Scaffold(
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
        body: PostList(),

        // Add post button

        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddPostPanel(),
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
