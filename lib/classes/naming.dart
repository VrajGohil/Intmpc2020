import 'package:flutter/material.dart';

class naming extends StatelessWidget {
   naming({
    this.judgename,
  });
   final String judgename;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(judgename,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'George',
        ),
      ),
    );
  }
}
