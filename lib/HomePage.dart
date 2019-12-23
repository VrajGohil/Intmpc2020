import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';
import 'package:intmpc/classes/custom_button.dart';
import 'classes/circledp.dart';
import 'classes/custom_page.dart';
import 'classes/custom_text_card.dart';

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
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/whiteBg.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
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
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.45,
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          CustomButton(
                            text: 'Participate Now',
                            method: () {
                              Navigator.pushNamed(context, '/dashboard');
                            },
                          ),
                        ],
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
                  ],
                ),
              ),
              CustomPage(
                title: 'How To Enter',
                imagePath: 'assets/blackBg.png',
                fontColor: Colors.white,
                body: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomTextCard(text: 'Click on \"Participate Now\" button on homepage.',number: '1.',),
                      CustomTextCard(text: 'Sign-up which you are most comfortable with.',number: '2.',),
                      CustomTextCard(text: 'On the dashboard, click on \"Submit a photo\"\n and upload your entry.',number: '3.',),
                      CustomTextCard(text: 'Ensure that you are able to see \nyour entry on your dashboard.',number: '4.',),
                      CustomTextCard(text: 'First entry is free for all.', number: '5.',),
                      CustomTextCard(text: 'Earn more entries by sharing this with friend', number: '6.',),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text('IF YOU STILL FACE ANY DIFFICULTY TO ENTER THE CONTEST, MAIL US AT help@intmpc2020.co AND WE WILL BE HAPPY TO ASSIST YOU.',style: TextStyle(fontFamily: 'George',fontSize: 14.0),textAlign: TextAlign.center,),
                      )
                    ],
                  ),
                ),
              ),
              CustomPage(
                title: 'Awards',
                imagePath: 'assets/whiteBg.png',
                fontColor: Colors.black,
              ),
              CustomPage(
                title: 'Host',
                imagePath: 'assets/blackBg.png',
                fontColor: Colors.white,
              ),
              CustomPage(
                title: 'Jury',
                imagePath: 'assets/whiteBg.png',
                fontColor: Colors.black,
                body: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        CircleDp(
                          address: 'assets/alina.jpg',
                          name: 'Alina Dotsenko',
                        ),
                        CircleDp(
                          address: 'assets/muhammad.jpg',
                          name: 'Muhammad Otib',
                        ),
                        CircleDp(
                          address: 'assets/tapan.jpg',
                          name: 'Tapan Sheth',
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        CircleDp(
                          address: 'assets/bill.jpg',
                          name: 'Dr. Bill Chu',
                        ),
                        CircleDp(
                          address: 'assets/peter.jpg',
                          name: 'Peter Wyss',
                        ),
                        CircleDp(
                          address: 'assets/thamaphon.jpg',
                          name: 'Thamaphon Suwankosai',
                        ),
                        CircleDp(
                          address: 'assets/yan.jpg',
                          name: 'Yan Hidayat',
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        CircleDp(
                          address: 'assets/logo.png',
                          name: 'Karen Webster',
                        ),
                        CircleDp(
                          address: 'assets/raj.jpg',
                          name: 'Raj Bheda',
                        ),
                        CircleDp(
                          address: 'assets/vraj.jpg',
                          name: 'Vraj Gohil',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CustomPage(
                title: 'INTMPC\n  2018',
                imagePath: 'assets/blackBg.png',
                fontColor: Colors.white,
              ),
              CustomPage(
                title: 'Contact',
                imagePath: 'assets/whiteBg.png',
                fontColor: Colors.black,
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

