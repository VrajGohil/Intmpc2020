import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  CustomTextField({this.text,this.padding});
  final String text;
  final double padding;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
        EdgeInsets.all(padding),
        child: Container(
          width: MediaQuery.of(context).size.height * 0.4,
          child: TextField(
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'George',
            ),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: text,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontFamily: 'George',
              ),
              fillColor: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}