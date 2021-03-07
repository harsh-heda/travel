import 'package:flutter/material.dart';

class Desc extends StatelessWidget {
  const Desc(
      {Key key,
      this.from,
      this.to,
      this.date,
      this.time,
      this.name,
      this.timestamp})
      : super(key: key);

  final String to;
  final String from;
  final String date;
  final String time;
  final String name;
  final String timestamp;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$name',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            'From : $from',
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
          ),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 2)),
          Text(
            'To : $to',
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            'Date : $date',
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Time : $time',
                style: const TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.w600),
              ),
              if (timestamp != null) Text('Posted on: $timestamp')
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          Divider(
            thickness: 1,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
