import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intmpc/classes/custom_text_field.dart';
import 'package:intmpc/classes/custom_button.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Color.fromRGBO(210, 210, 210, 1.0)],
            ),
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 180.0,
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
              ),
              Center(
                child: CustomPaint(
                  foregroundPainter: ShapesPainter(),
                  child: Container(
                    width: 350.0,
                    height: 410.0,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: 90.0),
                  child: CircleAvatar(
                    backgroundColor: Color.fromRGBO(210, 210, 210, 1.0),
                    radius: 40.0,
                    child: Icon(
                      CupertinoIcons.person_solid,
                      size: 95.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 170,
                  ),
                  CustomTextField(
                    text: 'Email',
                    padding: 0.5,
                  ),
                  CustomTextField(
                    text: 'Password',
                    padding: 0.5,
                  ),
                  FlatButton(
                    onPressed: () {
                      //TODO: ADD ACTION
                    },
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                        fontFamily: 'George',
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 410.0),
                  child: CustomButton(
                    text: 'SIGN IN',
                    method: () {
                      //TODO: ADD ACTION
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: <Widget>[
                   //TODO: ADD ICONS
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.white;
    // create a path
    var path = Path();
    path.moveTo(0, size.height / 2);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height / 2 - size.height / 5);

    // close the path to form a bounded shape
    path.close();
    canvas.drawShadow(path, Colors.grey.shade200, 15.0, false);
    canvas.drawPath(path, paint);
    // set the color property of the paint
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
