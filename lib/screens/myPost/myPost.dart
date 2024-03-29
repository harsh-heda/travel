import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel/models/posts.dart';
import 'package:travel/services/database.dart';
import 'package:travel/screens/myPost/myPost_postList.dart';
import 'package:provider/provider.dart';

class MyPost extends StatefulWidget {
  @override
  _MyPostState createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String uid;
  String _inputData() {
    final User user = auth.currentUser;
    if (user != null) return user.uid.toString();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PostData>>.value(
      value: DatabaseService(uid: _inputData()).myPost,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Posts'),
          backgroundColor: Colors.blue[400],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    // colorFilter: ColorFilter.mode(
                    //     Colors.blue[600], BlendMode.colorDodge),
                    image: AssetImage('assets/Travel.jpg'),
                    fit: BoxFit.cover)),
            child: MyPostPostList()),
      ),
    );
  }
}
