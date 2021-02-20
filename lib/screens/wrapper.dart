import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/models/users.dart';
import 'package:travel/screens/auth/auth.dart';
import 'package:travel/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    if (user == null)
      return Auth();
    else
      return Home();
  }
}
