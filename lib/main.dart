import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intmpc/HomePage.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:kf_drawer/kf_drawer.dart';

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
        home: MainWidget(),
        duration: 4000,
        type: AnimatedSplashType.StaticDuration,
      ),
    ),
  );
}

class MainWidget extends StatefulWidget {
  MainWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  KFDrawerController _drawerController;

  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: HomePage(),
      items: [
        KFDrawerItem.initWithPage(
          text: Text('HOME', style: TextStyle(color: Colors.white)),
          icon: Icon(Icons.home, color: Colors.white),
          page: HomePage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'CALENDAR',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.calendar_today, color: Colors.white),
//          page: CalendarPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'SETTINGS',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.settings, color: Colors.white),
//          page: ClassBuilder.fromString('SettingsPage'),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KFDrawer(
//        borderRadius: 0.0,
//        shadowBorderRadius: 0.0,
//        menuPadding: EdgeInsets.all(0.0),
//        scrollable: true,
        controller: _drawerController,
        header: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            width: MediaQuery.of(context).size.width * 0.6,
            child: Image.asset(
              'assets/logo.png',
              alignment: Alignment.centerLeft,
            ),
          ),
        ),
        footer: KFDrawerItem(
          text: Text(
            'SIGN IN',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.input,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) {
                return Text('hello');
              },
            ));
          },
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromRGBO(255, 255, 255, 1.0), Colors.black],
            tileMode: TileMode.repeated,
          ),
        ),
      ),
    );
  }
}