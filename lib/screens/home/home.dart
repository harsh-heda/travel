import 'package:flutter/material.dart';
import 'package:travel/screens/filter/filter.dart';
import 'package:travel/screens/home/travelPost_form.dart';
import 'package:travel/services/auth.dart';
import 'package:travel/services/database.dart';
import 'package:travel/models/posts.dart';
import 'package:provider/provider.dart';
import 'package:travel/screens/home/post_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  bool filter = false;
  Map<String, dynamic> value = new Map();
  @override
  Widget build(BuildContext context) {
    _navigateNextPageAndRetriveValue(BuildContext context) async {
      Map<String, dynamic> data = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Filter()),
      );
      if (data == null || data.isEmpty)
        setState(() => filter = !filter);
      else {
        setState(() => value = data);
      }
    }

    void _showAddPostPanel() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                  child: TravelPostForm(),
                ),
              ),
            );
          });
    }

    if (!filter) {
      return StreamProvider<List<PostData>>.value(
        value: DatabaseService().postData,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Travel Buddy'),
            backgroundColor: Colors.lightBlueAccent[400],
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.filter_alt_rounded),
                  iconSize: 40,
                  onPressed: () {
                    setState(() => filter = !filter);
                    _navigateNextPageAndRetriveValue(context);
                  }),
              IconButton(
                  icon: Icon(Icons.assignment_rounded),
                  iconSize: 40,
                  onPressed: () {
                    Navigator.pushNamed(context, '/myPost');
                  }),
              // IconButton(
              //   icon: Icon(Icons.account_circle_sharp),
              //   iconSize: 40,
              //   onPressed: () async {
              //     await _auth.signOut();
              //   },
              PopupMenuButton(
                onSelected: (value) async {
                  if (value == 'logout')
                    await _auth.signOut();
                  else {
                    Navigator.pushNamed(context, '/profile');
                  }
                },
                icon: Icon(Icons.account_circle_sharp),
                iconSize: 40,
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  const PopupMenuItem(
                    value: 'myprofile',
                    child: ListTile(
                      title: Text('My Profile'),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'logout',
                    child: ListTile(
                      title: Text('Logout'),
                    ),
                  ),
                ],
              )
            ],
          ),
          body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/Travel.jpg'),
                      // colorFilter: ColorFilter.mode(
                      //     Colors.blue[500], BlendMode.colorDodge),
                      fit: BoxFit.cover)),
              child: PostList()),

          // Add post button

          floatingActionButton: FloatingActionButton(
            onPressed: () => _showAddPostPanel(),
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
        ),
      );
    } else {
      return StreamProvider<List<PostData>>.value(
        value: DatabaseService().postData,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Travel Buddy'),
            backgroundColor: Colors.lightBlueAccent[400],
          ),
          body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/Travel.jpg'),
                      // colorFilter: ColorFilter.mode(
                      //     Colors.blue[500], BlendMode.colorDodge),
                      fit: BoxFit.cover)),
              child: PostList(filter: value)),

          // Add post button

          floatingActionButton: FloatingActionButton(
            onPressed: () => setState(() => filter = !filter),
            child: Icon(Icons.cancel),
            backgroundColor: Colors.blue,
          ),
        ),
      );
    }
  }
}
