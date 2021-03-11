import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel/shared/constans.dart';
import 'package:travel/services/database.dart';
import 'package:travel/shared/loading.dart';

class ProfilePostForm extends StatefulWidget {
  @override
  _ProfilePostFormState createState() => _ProfilePostFormState();
  final String pid;
  ProfilePostForm({this.pid});
}

class _ProfilePostFormState extends State<ProfilePostForm> {
  final _formKey = GlobalKey<FormState>();

  String _selectedTime = 'Select time';
  String _currTo;
  String _currFrom;
  DateTime _currDate;
  String _currTime;
  String error = '';

  //date time piceker
  Future<void> _openDatePicker(BuildContext context) async {
    final DateTime d = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030));

    if (d != null) {
      setState(() {
        _currDate = d;
      });
    }
  }
  // time picker

  Future<void> _openTimePicker(BuildContext context) async {
    final TimeOfDay t =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (t != null) {
      setState(() {
        _selectedTime = t.hour.toString() + ':' + t.minute.toString();
        _currTime = _selectedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.pid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text("Add your travel post", style: TextStyle(fontSize: 18)),
                  SizedBox(
                    height: 15,
                  ),
                  // text field for from
                  TextFormField(
                    initialValue: _currFrom ?? snapshot.data.data()['from'],
                    decoration: textInputDecoration.copyWith(hintText: "from"),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a valid location' : null,
                    onChanged: (val) {
                      setState(() => _currFrom = val);
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  // text field for to

                  TextFormField(
                    initialValue: _currTo ?? snapshot.data.data()['to'],
                    decoration: textInputDecoration.copyWith(hintText: "to"),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a valid location' : null,
                    onChanged: (val) {
                      setState(() => _currTo = val);
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 5)),

                    // date calender

                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        _openDatePicker(context);
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(_currDate ??
                        DateFormat.yMMMd('en_US')
                            .format(snapshot.data.data()['date'].toDate())
                            .toString()),

                    SizedBox(
                      width: 10,
                    ),

                    // select time

                    IconButton(
                      icon: Icon(Icons.alarm),
                      onPressed: () {
                        _openTimePicker(context);
                      },
                    ),

                    SizedBox(
                      width: 10,
                    ),
                    Text(_currTime ?? snapshot.data.data()['time']),
                  ]),
                  //time clock
                  SizedBox(
                    height: 15,
                  ),
                  //submit button
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: widget.pid).updatePost(
                              _currTo, _currFrom, _currDate, _currTime);
                        }
                      },
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent)),
                      child: Text("Update",
                          style: TextStyle(color: Colors.white))),
                  SizedBox(
                    height: 15,
                  ),
                  Text(error,
                      style: TextStyle(color: Colors.red, fontSize: 15)),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
