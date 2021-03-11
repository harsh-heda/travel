import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel/models/users.dart';
import 'package:travel/services/database.dart';
import 'package:travel/shared/loading.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String uid;
  String _inputData() {
    final User user = auth.currentUser;
    if (user != null) return user.uid.toString();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: _inputData()).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/Travel.jpg'),
                      // colorFilter: ColorFilter.mode(
                      //     Colors.blue[500], BlendMode.colorDodge),
                      fit: BoxFit.cover)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      size: 100,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text(
                            'Firstname : ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            userData.firstName.toUpperCase(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text(
                            'Lastname : ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            userData.lastName.toUpperCase(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
