import 'package:flutter/material.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: PageView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Center(
                  child: Image.asset(
                    'assets/whiteBg.png',
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: FlatButton(
                      onPressed: () {
                        //TODO: Add menu here
                      },
                      child: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Image.asset('assets/logo.png'),
                        width: 600.0,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      FloatingActionButton.extended(
                        onPressed: () {
                          //TODO: Add action here
                        },
                        backgroundColor: Colors.black,
                        label: Text("Participate Now"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                Center(
                  child: Image.asset(
                    'assets/blackBg.png',
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ],
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }
}

