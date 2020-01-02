import 'package:flutter/material.dart';

class CustomPage extends StatelessWidget {
  CustomPage({
    this.title,
    this.body,
    this.imagePath,
    this.fontColor
  });
  final String title;
  final Widget body;
  final String imagePath;
  final Color fontColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.fill,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  shape: BeveledRectangleBorder(side: BorderSide(color: fontColor, width: 3.0),),
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'George',
                        color: fontColor,
                        fontSize: 42.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
