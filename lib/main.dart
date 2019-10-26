import 'package:flutter/material.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  PageController _controller;
  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _handleOnPressed() {
      setState(() {
        isPlaying = !isPlaying;
        isPlaying
            ? _animationController.forward()
            : _animationController.reverse();
      });
    }

    return MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: <Widget>[
            PageView(
              controller: _controller,
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_up,
                            color: Colors.black,
                          ),
                          onPressed: () {}),
                    ),
                    SafeArea(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          iconSize: 50,
                          icon: AnimatedIcon(
                            icon: AnimatedIcons.menu_close,
                            color: Colors.black,
                            size: 35.0,
                            progress: _animationController,
                          ),
                          onPressed: () => _handleOnPressed(),
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
                            foregroundColor: Colors.white,
                            label: Text(
                              'Participate Now',
                              style: TextStyle(fontFamily: 'George'),
                            ),
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
                    SafeArea(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'How To Enter',
                            style: TextStyle(
                              fontFamily: 'Brush',
                              color: Colors.white,
                              fontSize: 50.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Awards',
                            style: TextStyle(
                              fontFamily: 'Brush',
                              color: Colors.black,
                              fontSize: 50.0,
                            ),
                          ),
                        ),
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
                    SafeArea(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Host',
                            style: TextStyle(
                              fontFamily: 'Brush',
                              color: Colors.white,
                              fontSize: 50.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Jury',
                            style: TextStyle(
                              fontFamily: 'Brush',
                              color: Colors.black,
                              fontSize: 50.0,
                            ),
                          ),
                        ),
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
                    SafeArea(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'INTMPC\n  2018',
                            style: TextStyle(
                              fontFamily: 'Brush',
                              color: Colors.white,
                              fontSize: 50.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Contact',
                            style: TextStyle(
                              fontFamily: 'Brush',
                              color: Colors.black,
                              fontSize: 50.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              scrollDirection: Axis.vertical,
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: ScrollingPageIndicator(
                  dotColor: Colors.grey,
                  dotSelectedColor: Colors.grey.shade700,
                  dotSize: 4,
                  dotSelectedSize: 10,
                  dotSpacing: 18,
                  controller: _controller,
                  itemCount: 7,
                  orientation: Axis.vertical,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
