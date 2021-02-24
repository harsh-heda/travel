import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel/models/posts.dart';
import 'package:travel/services/database.dart';
import 'package:travel/screens/myProfile/profile_postList.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
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
        body: ProfilePostList(),
      ),
    );
  }
}
