import 'package:flutter/material.dart';

class CircleDp extends StatelessWidget {
  CircleDp({this.address, this.name});
  final String address;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: CircleAvatar(
              backgroundImage: AssetImage(address),
              radius: 38.0,
            ),
            margin: EdgeInsets.all(20.0),
          ),
        ),
        Container(
          child: Text(
            name,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'George',
            ),
          ),
        ),
      ],
    );
  }
}
