import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  CustomButton({this.text,this.method});
  final String text;
  final Function method;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: method,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      label: Text(
        text,
        style: TextStyle(fontFamily: 'George'),
      ),
    );
  }
}