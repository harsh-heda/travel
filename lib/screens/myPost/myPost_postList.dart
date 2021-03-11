import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/models/posts.dart';
import 'package:travel/screens/myPost/myPost_CustomCard.dart';
import 'package:travel/shared/loading.dart';

class ProfilePostList extends StatefulWidget {
  @override
  _ProfilePostListState createState() => _ProfilePostListState();
}

class _ProfilePostListState extends State<ProfilePostList> {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<PostData>>(context) ?? [];
    if (posts.length == 0)
      return Loading();
    else {
      return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return ProfileCustomCard(post: posts[index]);
          });
    }
  }
}
