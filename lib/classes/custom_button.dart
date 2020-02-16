import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  CustomButton({this.text,this.method,this.tag = 'button'});
  final String text;
  final Function method;
  final String tag;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: tag,
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