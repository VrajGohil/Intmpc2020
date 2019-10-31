import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';
import 'package:intmpc/classes/custom_button.dart';

class HomePage extends KFDrawerContent {
  HomePage({
    Key key,
  });
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  PageController _controller;
  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      onPressed: () {
                        _controller.nextPage(
                            duration: Duration(seconds: 1),
                            curve: Curves.easeInOut);
                      },
                    ),
                  ),
                  SafeArea(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        iconSize: 50,
                        icon: Icon(
                          Icons.menu,
                          color: Colors.black,
                          size: 35.0,
                        ),
                        onPressed: widget.onMenuPressed,
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
                        CustomButton(
                          text: 'Participate Now',
                          method: () {
                            print("Clicked on participate");
                          },
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
    );
  }
}
