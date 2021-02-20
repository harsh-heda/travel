import 'package:flutter/material.dart';
import 'package:travel/shared/constans.dart';

class TravelPostForm extends StatefulWidget {
  @override
  _TravelPostFormState createState() => _TravelPostFormState();
  static final now = DateTime.now();
}

class _TravelPostFormState extends State<TravelPostForm> {
  final _formKey = GlobalKey<FormState>();

  String to;
  String from;
  DateTime date;
  TimeOfDay time;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text("Add your travel post", style: TextStyle(fontSize: 18)),
          SizedBox(
            height: 20,
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
            height: 20,
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
            height: 20,
          ),
          // Row(children: <Widget>[
          //   // date calender
          //   Text(date == null ? 'Date not selected' : date.toString()),
          //   SizedBox(
          //     width: 20,
          //   ),
          //   RaisedButton(
          //       child: Text('Pick a date'),
          //       onPressed: () {
          //         showDatePicker(
          //                 context: context,
          //                 initialDate: DateTime.now(),
          //                 firstDate: DateTime.now(),
          //                 lastDate: DateTime(2030))
          //             .then((date) {
          //           setState(() {
          //             date = date;
          //             print(date);
          //           });
          //         });
          //       }),
          // ]),
          //time clock
          SizedBox(
            height: 20,
          ),
          //submit button
          RaisedButton(
              onPressed: () async {
                print(to);
                print(from);
              },
              color: Colors.redAccent,
              child: Text("Add", style: TextStyle(color: Colors.white)))
        ],
      ),
    );
  }
}
