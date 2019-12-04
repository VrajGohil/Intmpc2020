import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intmpc/HomePage.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'classes/MyFirebaseAuth.dart';
import 'dashboard.dart';
import 'login_page.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/' : (context) => MainWidget(),
        '/login' : (context) => LoginPage(),
        '/dashboard' : (context) => Dashboard(),
      },
      initialRoute: '/',
//      home: MainWidget(),
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
  String signIn = 'SIGN IN';
  MyFirebaseAuth myFirebaseAuth;

  Future<void> getSignIn() async {
    myFirebaseAuth = MyFirebaseAuth();
    String userEmail = await myFirebaseAuth.getUser();
    if (userEmail != null){
      setState(() {
        signIn = 'SIGN OUT';
      });
    }
  }

  @override
  void initState() {
    getSignIn();
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
        controller: _drawerController,
        header: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Image.asset(
              'assets/logo.png',
              alignment: Alignment.centerLeft,
            ),
          ),
        ),
        footer: KFDrawerItem(
          text: Text(
            signIn,
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.input,
            color: Colors.white,
          ),
          onPressed: () {
            if(signIn == 'SIGN OUT'){
              myFirebaseAuth.signOut();
              setState(() {
                signIn = 'SIGN IN';
              });
            }
            else{
              Navigator.pushNamed(context, '/login');
            }
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