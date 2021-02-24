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
  void _inputData() {
    final User user = auth.currentUser;
    setState(() => uid = user.uid);
  }

  @override
  Widget build(BuildContext context) {
    _inputData();
    return StreamProvider<List<PostData>>.value(
      value: DatabaseService(uid: uid).myPost,
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
