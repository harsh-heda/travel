import 'package:flutter/material.dart';
import 'package:travel/services/auth.dart';
import 'package:travel/shared/constans.dart';
import 'package:travel/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //loading state
  bool loading = false;

  //text field input

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blue[100],
            appBar: AppBar(
              backgroundColor: Colors.blue[600],
              title: Text('Sign in to meet travel buddy'),
              actions: <Widget>[
                TextButton.icon(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 25,
                  ),
                  label: Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 60),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),

                    // email field

                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a valid email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // password field

                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      obscureText: true,
                      validator: (val) => val.length < 6
                          ? 'Enter atleast 6 character password '
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // sign in button

                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic res = await _auth.signInWithEmailAndPassword(
                              email, password);
                          if (res == null) {
                            setState(() {
                              error = 'Please check your email or password';
                              loading = false;
                            });
                          }
                        }
                      },
                      child: Text('Sign In',
                          style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(error,
                        style: TextStyle(color: Colors.red, fontSize: 15)),
                  ],
                ),
              ),
            ));
  }
}
