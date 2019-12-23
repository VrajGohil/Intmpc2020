import 'package:flutter/material.dart';

class CustomTextCard extends StatelessWidget {
  CustomTextCard({@required this.text,this.number});
  final String text;
  final String number;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Card(
          elevation: 24.0,
          color: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              number,
              style: TextStyle(color: Colors.white, fontFamily: 'George'),
            ),
          ),
        ),
        Card(
            elevation: 24.0,
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontFamily: 'George'),
              ),
            )),
      ],
    );
  }
}
