import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/models/posts.dart';
import 'package:travel/screens/home/customCard.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<PostData>>(context) ?? [];
    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return CustomCard(post: posts[index]);
        });
  }
}
