import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFCA437A),
          title: Center(
            child: Text(
              "INTMPC 2020",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: HelloWorld(),
      ),
    ),
  );
}

class HelloWorld extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
        colors: [const Color(0xFF915FB5), const Color(0xFFCA436B)],
      )),
      child: Center(
        child: Text(
          'Website Under development.\nStay tuned!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  /*@override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.blueAccent,
        child: Center(
          child: Text(
            'Website Under development.\nStay tuned!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }*/
}
