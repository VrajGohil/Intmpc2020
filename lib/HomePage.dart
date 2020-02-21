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
                title: 'Timeline',
                imagePath: 'assets/blackBg.png',
                fontColor: Colors.white,
                body: Stack(
                  children: <Widget>[
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.grey.withOpacity(0.5),
                          width: 4.0,
                          height: MediaQuery.of(context).size.height * 0.8,
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomTextCard(
                            text: 'Entry Window will remain open from 25th Feb till 10th March',
                            number: 'Start',
                          ),
                          CustomTextCard(
                            text: 'Best Entries to be shortlisted for the final round.',
                            number: 'Shortlisting Entries',
                          ),
                          CustomTextCard(
                            text:
                                'Results are planned to be announced on 17th of March 2020',
                            number: 'Result Declaration',
                          ),
                          CustomTextCard(
                            text:
                                'The shipping of the prizes would be done by the sponsoring companies, which could vary for short period of time.',
                            number: 'Prize Distribution',
                          ),
                        ],
                      ),
                    ),
                  ],
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
                      width: MediaQuery.of(context).size.width * 0.9,
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
                                  'We are thrilled to be partnering with some best brands to award the winners of International Macro Photography Contest 2020 some awesome prizes.\n\nAlthough we work hard, a big part of making this possible lies in the hands of our sponsors and partners so we can proudly say that these are the companies that make everything possible. Please do take time and visit all the companies below.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'George',fontSize: 12.0),
                                ),
                              ),
                            ),
                          )),
                    ),
                    SizedBox(height: 16.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Company(
                          network: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/sand.png?alt=media&token=89dc715e-3eef-4759-ad71-7ff190aef6a9',
                          onTap: () => _launchURL(
                              'https://www.sandmarc.com/'),
                        ),
                        Company(
                          network:
                          'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/heli.png?alt=media&token=38952f3e-a8e8-4752-a4d2-76ff3bda7515',
                          onTap: () => _launchURL(
                              'https://www.heliconsoft.com/'),
                        ),
                      ],
                    ),
                    Company(
                      network:
                      'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/moment.png?alt=media&token=8f1f48f4-2e13-443e-b581-61c641df59d5',
                      onTap: () => _launchURL(
                          'https://www.shopmoment.com/'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Company(
                          network: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/on1.png?alt=media&token=ace9df9c-e309-4a85-a4a3-be990b4a7f62',
                          onTap: () => _launchURL(
                              'https://www.on1.com/'),
                        ),
                        Company(
                          network: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/guild.png?alt=media&token=3a7dad51-6e40-4d31-8430-2df9d2de5907',
                          onTap: () => _launchURL(
                              'https://photoguild.co.uk/'),
                        ),
                      ],
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
                          network: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/alina.jpg?alt=media&token=34db8a14-a027-4d8f-a39a-b4b19db04b1d',
                          name: 'Alina Dotsenko',
                        ),
                        CircleDp(
                          network: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/muhammad.jpg?alt=media&token=bd5e94a8-1c83-44e4-a042-dbb3285544c6',
                          name: 'Muhammad Otib',
                        ),
                        CircleDp(
                          network: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/tapan.jpg?alt=media&token=26ced153-957f-4df2-85e4-43ed79e8e724',
                          name: 'Tapan Sheth',
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        CircleDp(
                          network: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/bill.jpg?alt=media&token=6c999451-cf0e-4942-b1da-4cceff574ade',
                          name: 'Dr. Bill Chu',
                        ),
                        CircleDp(
                          network: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/peter.jpg?alt=media&token=3c0ab11e-0b07-419d-a080-f2f53699a64b',
                          name: 'Peter Wyss',
                        ),
                        CircleDp(
                          network: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/thamaphon.jpg?alt=media&token=d62f086a-2378-4ca0-938b-b227de3d16ce',
                          name: 'Thamaphon Suwankosai',
                        ),
                        CircleDp(
                          network: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/yan.jpg?alt=media&token=b6a1c2d3-d3aa-40ab-afd1-41fd5a767915',
                          name: 'Yan Hidayat',
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        CircleDp(
                          network: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/karen.jpg?alt=media&token=b3cd5272-daf2-49a8-bcd5-5b2786c9ee9e',
                          name: 'Karen Brewer',
                        ),
                        CircleDp(
                          network: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/raj.jpg?alt=media&token=7cfa6427-dfda-4dba-8a99-938f2051e834',
                          name: 'Raj Bheda',
                        ),
                        CircleDp(
                          network: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/vraj.jpg?alt=media&token=2f4e5383-3de8-44a2-93aa-ac7cc0339783',
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
                          'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/intmpc2018.png?alt=media&token=1242417b-3bda-4a00-9bbd-938dfd187917',
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
                          network: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/entry1.jpg?alt=media&token=6bfe9f5a-f78c-4be0-9530-e2a71c6b4d66',
                          name: 'Angela Manalili',
                          color: Colors.white,
                        ),
                        CircleDp(
                          network: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/entry2.jpg?alt=media&token=e2e347e3-38a0-4261-8ad8-9f82155a5cf4',
                          name: 'Alina Dotsenko',
                          color: Colors.white,
                        ),
                        CircleDp(
                          network: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/entry3.jpg?alt=media&token=5f437fa3-d0a0-4213-a334-bd30cd6f3767',
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
                        'Timeline',
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
                        'Sponsors',
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
