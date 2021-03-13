import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/models/posts.dart';
import 'package:travel/screens/home/customCard.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
  final Map<String, dynamic> filter;
  PostList({this.filter});
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<PostData>>(context) ?? [];
    if (widget.filter != null) {
      if (widget.filter['to'] != null) {
        posts.retainWhere((element) => element.to == null
            ? true
            : element.to.toUpperCase() == widget.filter['to'].toUpperCase());
      }
      if (widget.filter['from'] != null) {
        posts.retainWhere((element) => element.to == null
            ? true
            : element.from.toUpperCase() ==
                widget.filter['from'].toUpperCase());
      }
      if (widget.filter['startDate'] != null) {
        posts.retainWhere((element) => element.to == null
            ? true
            : element.date.microsecondsSinceEpoch >=
                    widget.filter['startDate'].microsecondsSinceEpoch &&
                element.date.microsecondsSinceEpoch <=
                    widget.filter['endDate'].microsecondsSinceEpoch);
      }
    }

    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return CustomCard(post: posts[index]);
        });
  }
}
