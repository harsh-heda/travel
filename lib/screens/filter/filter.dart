import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel/shared/constans.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final _formKey = GlobalKey<FormState>();

  String _selectedDate = "Select Date";
  //String _selectedTime = 'Select time';
  String to = "";
  String from = "";
  String date = "";
  String time = "";
  Map<String, String> data = new Map();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text("Filter travel post", style: TextStyle(fontSize: 18)),
                  SizedBox(
                    height: 15,
                  ),
                  // text field for from
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "from"),
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

                    // IconButton(
                    //   icon: Icon(Icons.alarm),
                    //   onPressed: () {
                    //     _openTimePicker(context);
                    //   },
                    // ),

                    // SizedBox(
                    //   width: 15,
                    // ),
                    // Text(_selectedTime),
                  ]),
                  //time clock
                  SizedBox(
                    height: 15,
                  ),
                  //submit button
                  ElevatedButton(
                      onPressed: () {
                        to.isEmpty
                            ? print('to filter not used')
                            : data['to'] = to;
                        from.isEmpty
                            ? print('from filter not used')
                            : data['from'] = from;
                        date.isEmpty
                            ? print('from filter not used')
                            : data['date'] = date;
                        Navigator.pop(context, data);
                      },
                      child: Text("Filter",
                          style: TextStyle(color: Colors.white))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
