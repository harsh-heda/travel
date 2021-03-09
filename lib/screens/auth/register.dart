import 'package:flutter/material.dart';
import 'package:travel/services/auth.dart';
import 'package:travel/shared/constans.dart';
import 'package:travel/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //loading state
  bool loading = false;
  //text field input

  String email = '';
  String password = '';
  String error = '';
  String firstName = '';
  String lastName = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.blue[100],
            appBar: AppBar(
              backgroundColor: Colors.blue[600],
              title: Text('Sign Up to meet your travel buddy'),
              actions: <Widget>[
                TextButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
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

                    //first name field
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'FirstName'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a valid email' : null,
                      onChanged: (val) {
                        setState(() => firstName = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // last name field
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'LastName'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a valid email' : null,
                      onChanged: (val) {
                        setState(() => lastName = val);
                      },
                    ),
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
                      validator: (val) => val.length < 6
                          ? 'Enter atleast 6 character password '
                          : null,
                      obscureText: true,
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
                          dynamic res =
                              await _auth.registerInWithEmailAndPassword(
                                  email, password, firstName, lastName);
                          if (res == null) {
                            setState(() {
                              error = 'Please give a valid email';
                              loading = false;
                            });
                          }
                        }
                      },
                      child: Text('Register',
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
