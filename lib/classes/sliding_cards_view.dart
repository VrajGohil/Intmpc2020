import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

class SlidingCardsView extends StatefulWidget {
  @override
  _SlidingCardsViewState createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  PageController pageController;
  double pageOffset = 0;
  List<SlidingCard> content;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateSlider());
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _animateSlider() {
    Future.delayed(Duration(seconds: 2)).then((_) {
      int nextPage = pageController.page.round() + 1;

      if (nextPage == content.length) {
        nextPage = 0;
      }

      pageController
          .animateToPage(nextPage,
              duration: Duration(seconds: 1), curve: Curves.linear)
          .then((_) => _animateSlider());
    });
  }

  @override
  Widget build(BuildContext context) {
    content = [
      SlidingCard(
        name:
            '\$250 Credit at shopmoment.co and Helicon Focus Pro lifetime license worth \$200',
        network: 'https://i.ibb.co/JnPhwfC/20200209-180659-0000.png',
        offset: pageOffset,
        rank: 'https://i.ibb.co/S0CKHb6/rank1.png',
      ),
      SlidingCard(
          name:
              '\$200 Credit at shopmoment.co and Helicon Focus Pro lifetime license worth \$200',
          network: 'https://i.ibb.co/whMTdt4/20200215-164232-0000.png',
          offset: pageOffset - 1,
          rank: 'https://i.ibb.co/N1TM8Fj/rank2.png'),
      SlidingCard(
        name:
            '\$Macro lens from Sandmarc and Helicon Focus Pro lifetime license worth \$200',
        network: 'https://i.ibb.co/hYfbNsB/20200215-174904-0000.png',
        offset: pageOffset - 2,
        rank: 'https://i.ibb.co/THbMZqZ/rank3.png',
      ),
    ];
    return Container(
      height: 400.0,
      child: PageView(
        controller: pageController,
        children: content,
      ),
    );
  }
}

class SlidingCard extends StatelessWidget {
  final String name;
  final String rank;
  final String network;
  final double offset;

  const SlidingCard({
    Key key,
    @required this.name,
    @required this.network,
    @required this.offset,
    @required this.rank,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Image.network(
              rank,
              fit: BoxFit.fitHeight,
            ),
          ),
          Card(
            margin: EdgeInsets.only(left: 8, right: 8, bottom: 24, top: 40),
            elevation: 4,
            color: Colors.white.withOpacity(0.3),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Container(
              width: 400,
              height: 180,
              child: Image.network(
                network,
//              height: MediaQuery.of(context).size.height * 0.3,
//              width: MediaQuery.of(context).size.width * 0.9,
                alignment: Alignment(-offset.abs(), 0),
                fit: BoxFit.fitWidth,
                loadingBuilder: (context, child, progress) {
                  return progress == null
                      ? child
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            ),
          ),
          SizedBox(height: 16.0),
          CardContent(
            name: name,
            offset: gauss,
          ),
        ],
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String name;
  final double offset;

  const CardContent({Key key, @required this.name, @required this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.translate(
            offset: Offset(8 * offset, 0),
            child: Text(name,
                style: TextStyle(
                    fontSize: 12.0, fontFamily: 'George', color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
