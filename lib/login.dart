import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
              ),
              Center(
                child: CustomPaint(
                  foregroundPainter: ShapesPainter(),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 1.0,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.13),
                  child: CircleAvatar(
                    backgroundColor: Color.fromRGBO(210, 210, 210, 1.0),
                    radius: MediaQuery.of(context).size.width * 0.1,
                    child: Icon(
                      CupertinoIcons.person_solid,
                      size: MediaQuery.of(context).size.width * 0.24,
                      color: Colors.white,
                    ),
                  ),
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
