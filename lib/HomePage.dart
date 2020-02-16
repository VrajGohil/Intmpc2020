import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';
import 'package:intmpc/classes/custom_button.dart';
import 'classes/circledp.dart';
import 'classes/company.dart';
import 'classes/custom_page.dart';
import 'classes/custom_text_card.dart';
import 'classes/sliding_cards_view.dart';
import 'classes/statcard.dart';
import 'package:url_launcher/url_launcher.dart';

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
  int _currentPage = 0;
  int t; //Tid
  double p; //Position

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final blackLine = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.black.withOpacity(0.4),
        height: 1.0,
        width: 32.0,
      ),
    );

    final fontSize = MediaQuery.of(context).size.height <= 600.0
        ? MediaQuery.of(context).size.height * 0.03
        : 32.0;

    var _greyText = TextStyle(
        fontSize: 16.0, fontFamily: 'George', color: Colors.grey.shade700);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _controller,
            physics: ClampingScrollPhysics(),
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
                            child: Hero(
                              child: Image.asset('assets/logo.png'),
                              tag: 'logo',
                            ),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.45,
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          CustomButton(
                            text: 'Participate Now',
                            method: () async {
                              FirebaseAuth _auth = FirebaseAuth.instance;
                              await _auth.currentUser() != null
                                  ? Navigator.pushNamed(context, '/dashboard')
                                  : Navigator.pushNamed(context, '/login');
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
                      CustomTextCard(
                        text: 'Click on Participate Now button on homepage.',
                        number: '1.',
                      ),
                      CustomTextCard(
                        text: 'Sign-up which you are most comfortable with.',
                        number: '2.',
                      ),
                      CustomTextCard(
                        text:
                            'On the dashboard, click on \"Submit a photo\" and upload your entry.',
                        number: '3.',
                      ),
                      CustomTextCard(
                        text:
                            'Ensure that you are able to see your entry on your dashboard.',
                        number: '4.',
                      ),
                      CustomTextCard(
                        text:
                            'You can submit total 3 entries so don\'t forget to utilise all three entries.',
                        number: '5.',
                      ),
                      CustomTextCard(
                        text:
                            'Sit back and chill while we evaluate your entries.',
                        number: '6.',
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SelectableText(
                          'IF YOU STILL FACE ANY DIFFICULTY TO ENTER THE CONTEST, MAIL US AT contact@intmpc2020.co AND WE WILL BE HAPPY TO ASSIST YOU.',
                          style:
                              TextStyle(fontFamily: 'George', fontSize: 12.0),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              CustomPage(
                title: 'Awards',
                imagePath: 'assets/whiteBg.png',
                fontColor: Colors.black,
                body: Container(
                  child: SlidingCardsView(),
                ),
              ),
              CustomPage(
                title: 'Sponsors',
                imagePath: 'assets/blackBg.png',
                fontColor: Colors.white,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Card(
                          elevation: 24.0,
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  'We are thrilled to be partnering with some best brands to award the winners of International Macro Photography Contest 2020 some awesome prizes.\n\nAlthough we work hard, a big part of making this possible lies in the hands of our sponsors and partners so we can proudly say that these are the companies that make everything possible.If you\'re interested in sponsoring alongside these companies, please get in touch with us!',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'George'),
                                ),
                              ),
                            ),
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Company(
                          network:
                              'https://i.ibb.co/vvzFLwj/20200216-161353-0000.png',
                          onTap: () => _launchURL(
                              'https://www.shopmoment.com/'),
                        ),
                        Company(
                          network:
                          'https://i.ibb.co/DkpmVSg/20200216-161900-0000.png',
                          onTap: () => _launchURL(
                              'https://www.heliconsoft.com/'),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Company(
                          network: 'https://i.ibb.co/nkJtySy/20200216-161648-0000.png',
                          onTap: () => _launchURL(
                              'https://www.sandmarc.com/'),
                        ),
                        Company(
                          network: 'https://i.ibb.co/qCq7fH1/20200216-161434-0000.png',
                          onTap: () => _launchURL(
                              'https://www.on1.com/'),
                        ),
                      ],
                    ),
                    Company(
                      network: 'https://i.ibb.co/7YQ7h5W/20200216-161615-0000.png',
                      onTap: () => _launchURL(
                          'https://photoguild.co.uk/'),
                    ),
                  ],
                ),
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
//                          address: 'assets/alina.jpg',
                          network: 'https://i.ibb.co/tqzXGbH/alina.jpg',
                          name: 'Alina Dotsenko',
                        ),
                        CircleDp(
//                          address: 'assets/muhammad.jpg',
                          network: 'https://i.ibb.co/0njyfbw/muhammad.jpg',
                          name: 'Muhammad Otib',
                        ),
                        CircleDp(
//                          address: 'assets/tapan.jpg',
                          network: 'https://i.ibb.co/TL7zDft/tapan.jpg',
                          name: 'Tapan Sheth',
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        CircleDp(
//                          address: 'assets/bill.jpg',
                          network: 'https://i.ibb.co/TrpbWjP/bill.jpg',
                          name: 'Dr. Bill Chu',
                        ),
                        CircleDp(
//                          address: 'assets/peter.jpg',
                          network: 'https://i.ibb.co/H71xkp6/peter.jpg',
                          name: 'Peter Wyss',
                        ),
                        CircleDp(
//                          address: 'assets/thamaphon.jpg',
                          network: 'https://i.ibb.co/8B3BnG6/thamaphon.jpg',
                          name: 'Thamaphon Suwankosai',
                        ),
                        CircleDp(
//                          address: 'assets/yan.jpg',
                          network: 'https://i.ibb.co/TLRfT5h/yan.jpg',
                          name: 'Yan Hidayat',
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        CircleDp(
//                          address: 'assets/karen.jpg',
                          network: 'https://i.ibb.co/6Hxm7qt/karen.jpg',
                          name: 'Karen Brewer',
                        ),
                        CircleDp(
//                          address: 'assets/raj.jpg',
                          network: 'https://i.ibb.co/qgTy4XQ/raj.jpg',
                          name: 'Raj Bheda',
                        ),
                        CircleDp(
//                          address: 'assets/vraj.jpg',
                          network: 'https://i.ibb.co/SRzXZrv/vraj.jpg',
                          name: 'Vraj Gohil',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CustomPage(
                title: 'INTMPC\n2018',
                imagePath: 'assets/blackBg.png',
                fontColor: Colors.white,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        StatCard(
                          numdata: '12k+',
                          type: 'Entries',
                        ),
                        Container(
                          color: Colors.white30,
                          height: 38,
                          width: 2,
                        ),
                        StatCard(
                          numdata: '10',
                          type: 'Judges',
                        ),
                        Container(
                          color: Colors.white30,
                          height: 38,
                          width: 2,
                        ),
                        StatCard(
                          numdata: '156',
                          type: 'Countries',
                        )
                      ],
                    ),
                    Container(
                      child: InkWell(
                        child: Image.network(
                          'https://i.ibb.co/1RnsL0j/intmpc2018.png',
                          loadingBuilder: (context, child, progress) {
                            return progress == null
                                ? child
                                : Center(
                                    child: LinearProgressIndicator(
                                      value: progress.cumulativeBytesLoaded /
                                          progress.expectedTotalBytes,
                                    ),
                                  );
                          },
                        ),
                        onTap: () => _launchURL('http://intmpc2018.gq'),
                      ),
                      width: 200,
                      height: 200,
                    ),
                    Title(
                      color: Colors.white,
                      child: Text(
                        'Winners',
                        style: TextStyle(
                          fontFamily: 'George',
                          fontSize: 28.0,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CircleDp(
                          network: 'https://i.ibb.co/86NDp3D/entry1.jpg',
                          name: 'Angela Manalili',
                          color: Colors.white,
                        ),
                        CircleDp(
                          network: 'https://i.ibb.co/cLQ01Kv/entry2.jpg',
                          name: 'Alina Dotsenko',
                          color: Colors.white,
                        ),
                        CircleDp(
                          network: 'https://i.ibb.co/sKpmdry/entry3.jpg',
                          name: 'Priyank Dhami',
                          color: Colors.white,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/whiteBg.png'),
                      fit: BoxFit.fill),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () => _controller.animateToPage(0,
                          duration: Duration(seconds: 2), curve: Curves.linear),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(
                          Icons.keyboard_arrow_up,
                          color: Colors.black.withOpacity(0.6),
                          size: 46.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    InkWell(
                      onTap: () => _controller.animateToPage(0,
                          duration: Duration(seconds: 2), curve: Curves.linear),
                      child: Text(
                        'Homepage',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: fontSize,
                            fontFamily: 'George'),
                      ),
                    ),
                    blackLine,
                    InkWell(
                      onTap: () => _controller.animateToPage(1,
                          duration: Duration(seconds: 2), curve: Curves.linear),
                      child: Text(
                        'How to enter',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: fontSize,
                            fontFamily: 'George'),
                      ),
                    ),
                    blackLine,
                    InkWell(
                      onTap: () => _controller.animateToPage(2,
                          duration: Duration(seconds: 2), curve: Curves.linear),
                      child: Text(
                        'Awards',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: fontSize,
                            fontFamily: 'George'),
                      ),
                    ),
                    blackLine,
                    InkWell(
                      onTap: () => _controller.animateToPage(3,
                          duration: Duration(seconds: 2), curve: Curves.linear),
                      child: Text(
                        'Sponsor spot',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: fontSize,
                            fontFamily: 'George'),
                      ),
                    ),
                    blackLine,
                    InkWell(
                      onTap: () => _controller.animateToPage(4,
                          duration: Duration(seconds: 2), curve: Curves.linear),
                      child: Text(
                        'Jury',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: fontSize,
                            fontFamily: 'George'),
                      ),
                    ),
                    blackLine,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 150.0,
                          width: 90.0,
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.instagram,
                              size: 50.0,
                              color: Colors.black,
                            ),
                            onPressed: () => _launchURL(
                                'https://instagram.com/macroandflora'),
                          ),
                        ),
                        Container(
                          height: 150.0,
                          width: 90.0,
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.patreon,
                              size: 50.0,
                              color: Colors.black,
                            ),
                            onPressed: () => _launchURL(
                                'https://www.patreon.com/intmpc2020'),
                          ),
                        ),
                        Container(
                          height: 150.0,
                          width: 90.0,
                          child: IconButton(
                            icon: Icon(
                              Icons.email,
                              size: 50.0,
                              color: Colors.black,
                            ),
                            onPressed: () =>
                                launch('mailto:contact@intmpc2020.co'),
                          ),
                        ),
                      ],
                    ),
                    FractionallySizedBox(),
                    SelectableText(
                      'Privacy Policy',
                      style: _greyText,
                      onTap: () => _launchURL(
                          'https://intmpc2020.co/privacy_policy.html'),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    SelectableText(
                      'Email: contact@intmpc2020.co',
                      style: _greyText,
                      onTap: () => launch('mailto:contact@intmpc2020.co'),
                    ),
                    Expanded(child: Container()),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Made with ❤️ by Vraj Gohil & Raj Bheda',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'George',
                              fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
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
