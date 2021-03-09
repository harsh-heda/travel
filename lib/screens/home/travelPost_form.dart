import 'package:flutter/material.dart';
import 'package:travel/shared/constans.dart';
import 'package:travel/services/database.dart';
import 'package:provider/provider.dart';
import 'package:travel/models/users.dart';
import 'package:intl/intl.dart';

class TravelPostForm extends StatefulWidget {
  @override
  _TravelPostFormState createState() => _TravelPostFormState();
}

class _TravelPostFormState extends State<TravelPostForm> {
  final _formKey = GlobalKey<FormState>();

  String _selectedDate = "Select Date";
  String _selectedTime = 'Select time';
  String to;
  String from;
  String date;
  String time;
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
        _selectedDate = new DateFormat.yMMMd('en_US').format(d).toString();
        date = _selectedDate;
      });
    }
  }
  // time picker

  Future<void> _openTimePicker(BuildContext context) async {
    final TimeOfDay t =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (t != null) {
      print(t);
      setState(() {
        _selectedTime = t.hour.toString() + ':' + t.minute.toString();
        time = _selectedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
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
            decoration: textInputDecoration.copyWith(hintText: "from"),
            validator: (val) =>
                val.isEmpty ? 'Please enter a valid location' : null,
            onChanged: (val) {
              setState(() => from = val);
            },
          ),
          SizedBox(
            height: 15,
          ),

          // text field for to

          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: "to"),
            validator: (val) =>
                val.isEmpty ? 'Please enter a valid location' : null,
            onChanged: (val) {
              setState(() => to = val);
            },
          ),
          SizedBox(
            height: 15,
          ),
          Row(children: <Widget>[
            // date calender

            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                _openDatePicker(context);
              },
            ),
            SizedBox(
              width: 10,
            ),
            Text(_selectedDate),

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
              width: 15,
            ),
            Text(_selectedTime),
          ]),
          //time clock
          SizedBox(
            height: 15,
          ),
          //submit button
          ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState.validate() &&
                    date != null &&
                    time != null) {
                  await DatabaseService(uid: user.uid)
                      .updateUserTravelData(to, from, date, time, user.uid);
                  setState(() => error = '');
                }
                if (time == null) {
                  setState(() => error = 'Please give a valid time');
                }
                if (date == null) {
                  setState(() => error = 'Please give a valid date');
                }
              },
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.redAccent)),
              child: Text("Add", style: TextStyle(color: Colors.white))),
          SizedBox(
            height: 15,
          ),
          Text(error, style: TextStyle(color: Colors.red, fontSize: 15)),
        ],
      ),
    );
  }
}
