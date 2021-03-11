import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/models/users.dart';
import 'package:travel/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:travel/services/auth.dart';
import 'screens/myPost/myPost.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
        value: AuthService().user,
        child: MaterialApp(routes: {
          '/': (context) => Wrapper(),
          '/myProfile': (context) => MyProfile()
        }));
  }
}
