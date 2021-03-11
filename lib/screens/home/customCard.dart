import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel/models/users.dart';
import 'package:travel/shared/desc.dart';
import 'package:travel/models/posts.dart';
import 'package:travel/services/database.dart';
import 'package:travel/shared/loading.dart';

class CustomCard extends StatelessWidget {
  final PostData post;
  CustomCard({this.post});
  @override
  Widget build(BuildContext context) {
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
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Desc(
                      name: userData.firstName.toUpperCase() +
                          ' ' +
                          userData.lastName.toUpperCase(),
                      to: post.to.toUpperCase(),
                      from: post.from.toUpperCase(),
                      date: DateFormat.yMMMd('en_US')
                          .format(post.date)
                          .toString(),
                      time: post.time,
                      timestamp: DateFormat.yMMMd('en_US')
                          .format(DateTime.parse(post.timestamp))
                          .toString(),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
