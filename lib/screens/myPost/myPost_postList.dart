import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/models/posts.dart';
import 'package:travel/screens/myPost/myPost_CustomCard.dart';
import 'package:travel/shared/loading.dart';

class MyPostPostList extends StatefulWidget {
  @override
  _MyPostPostListState createState() => _MyPostPostListState();
}

class _MyPostPostListState extends State<MyPostPostList> {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<PostData>>(context) ?? [];
    if (posts.length == 0)
      return Loading();
    else {
      return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return MyPostCustomCard(post: posts[index]);
          });
    }
  }
}
