import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intmpc/HomePage.dart';
import 'package:intmpc/rules.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'dashboard.dart';
import 'jury.dart';
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
        '/': (context) => MainWidget(),
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => Dashboard(),
        '/rules': (context) => Rules(),
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
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<KFDrawerItem> items = [
    KFDrawerItem.initWithPage(
      text: Text('HOME', style: TextStyle(color: Colors.white,fontFamily: 'George'),),
      icon: Icon(Icons.home, color: Colors.white),
      page: HomePage(),
    ),
  ];

  Future<void> getSignIn() async {
    String userEmail = (await _auth.currentUser()).email;
    if (userEmail != null) {
      setState(() {
        signIn = 'SIGN OUT';
        items.add(
          KFDrawerItem.initWithPage(
            text: Text(
              'DASHBOARD',
              style: TextStyle(color: Colors.white,fontFamily: 'George'),
            ),
            icon: Icon(Icons.dashboard, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, '/dashboard'),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    getSignIn();
    super.initState();
    _drawerController =
        KFDrawerController(initialPage: HomePage(), items: items);
    items.add(
      KFDrawerItem.initWithPage(
        text: Text(
          'RULES',
          style: TextStyle(color: Colors.white,fontFamily: 'George'),
        ),
        icon: Icon(Icons.receipt, color: Colors.white),
        onPressed: () => Navigator.pushNamed(context, '/rules'),
      ),
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
            style: TextStyle(color: Colors.white,fontFamily: 'George'),
          ),
          icon: Icon(
            Icons.input,
            color: Colors.white,
          ),
          onPressed: () {
            if (signIn == 'SIGN OUT') {
              _auth.signOut();
              setState(() {
                signIn = 'SIGN IN';
                items.removeLast();
              });
            } else {
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
