import 'package:flutter/material.dart';
import 'package:travel/models/users.dart';
import 'package:travel/shared/desc.dart';
import 'package:travel/models/posts.dart';
import 'package:travel/services/database.dart';
import 'package:travel/shared/loading.dart';
import 'package:travel/screens/myProfile/profilePost_form.dart';

class ProfileCustomCard extends StatelessWidget {
  final PostData post;
  ProfileCustomCard({this.post});

  @override
  Widget build(BuildContext context) {
    void _showAddPostPanel() {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                  child: ProfilePostForm(
                    pid: post.pid,
                  ),
                ),
              ),
            );
          });
    }

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: post.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    flex: 4,
                    fit: FlexFit.tight,
                    child: Desc(
                      name: userData.firstName + ' ' + userData.lastName,
                      to: post.to,
                      from: post.from,
                      date: post.date,
                      time: post.time,
                    ),
                  ),
                  Expanded(
                      child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _showAddPostPanel())),
                  Expanded(
                      child: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            print(post.pid);
                            DatabaseService(uid: post.pid).deletePost();
                          }))
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
