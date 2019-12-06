import 'package:flutter/material.dart';

class Circledp extends StatelessWidget {
  Circledp({
    this.imagesrc,
  });
  final String imagesrc;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: CircleAvatar(
          backgroundImage: AssetImage(imagesrc),
          radius: 38.0,
        ),
        margin: EdgeInsets.all(20.0),
      ),
    );
  }
}
