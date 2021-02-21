import 'package:flutter/material.dart';
import 'package:travel/screens/home/desc.dart';
import 'package:travel/models/posts.dart';

class CustomCard extends StatelessWidget {
  final PostData post;
  CustomCard({this.post});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Desc(
                to: post.to, from: post.from, date: post.date, time: post.time),
          ),
        ],
      ),
    );
  }
}
