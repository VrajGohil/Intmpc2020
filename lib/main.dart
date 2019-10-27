import 'package:flutter/material.dart';
import 'package:intmpc/HomePage.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplash(
        body: SizedBox(
          width: 250.0,
          child: FadeAnimatedTextKit(
              onTap: () {
                print("Tap Event");
              },
              text: [
                "INTMPC 2020",
              ],
              textStyle: TextStyle(
                  fontSize: 70.0,
                  fontFamily: "George",
                  color: Colors.black,
              ),
              textAlign: TextAlign.center,
              alignment: AlignmentDirectional.topStart // or Alignment.topLeft
          ),
        ),
        home: HomePage(),
        duration: 4000,
        type: AnimatedSplashType.StaticDuration,
      ),
    ),
  );
}
