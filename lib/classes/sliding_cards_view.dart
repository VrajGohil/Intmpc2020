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
    Future.delayed(Duration(seconds: 5)).then((_) {
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
            '\$250 Credit at shopmoment.co, Helicon Focus Pro lifetime license worth \$200 and 1 year standard membership from The Guild of Photographers worth \$99',
        network: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/prize1.jpeg?alt=media&token=7fb00ed3-63d1-48a9-aafd-b568b279d707',
        offset: pageOffset,
        rank: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/rank1.png?alt=media&token=36c1b653-78cd-42e2-9d57-c3ad3a24b60d',
      ),
      SlidingCard(
          name:
              '\$200 Credit at shopmoment.co and Helicon Focus Pro lifetime license worth \$200',
          network: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/prize_2.png?alt=media&token=193a4b07-fc36-423e-b7c7-4b7517d64227',
          offset: pageOffset - 1,
          rank: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/rank2.png?alt=media&token=a0e5aa2a-d148-465b-9b5b-3a366c766ce4'),
      SlidingCard(
        name:
            'Macro lens from Sandmarc and Helicon Focus Pro lifetime license worth \$200',
        network: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/prize_3.png?alt=media&token=095b8037-d663-4f9a-8874-63f61c2e27eb',
        offset: pageOffset - 2,
        rank: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/rank3.png?alt=media&token=9a74de3c-4f44-4f26-899c-7af4b1e63d2b',
      ),
      SlidingCard(
        name:
        'Helicon Focus Pro lifetime license worth \$200 for the most active participent of the event',
        network: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/prize_4_5.jpeg?alt=media&token=ad4ee802-4c75-4a9d-9551-b2e6a748ae56',
        offset: pageOffset - 3,
        rank: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/rank4.png?alt=media&token=c40136ce-e530-4458-b7da-38c218a38b53',
      ),
      SlidingCard(
        name:
        'Helicon Focus Pro lifetime license worth \$200',
        network: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/prize_4_5.jpeg?alt=media&token=ad4ee802-4c75-4a9d-9551-b2e6a748ae56',
        offset: pageOffset - 4,
        rank: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/rank5.png?alt=media&token=c298c9d3-a1fb-4dca-b20b-bd609c29e9b9',
      ),
      SlidingCard(
        name:
        'ON1 Photo Raw 2020 worth \$100',
        network: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/bonus_prize.jpeg?alt=media&token=662bf0a7-663c-4b53-861a-5eca2521b98c',
        offset: pageOffset - 5,
        rank: 'https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/bonus.png?alt=media&token=cce8821d-0e66-4fbb-9f5a-5dc046edd097',
      ),
    ];
    return Container(
//      height: 400.0,
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
              height: 200,
              child: Image.network(
                network,
//              height: MediaQuery.of(context).size.height * 0.3,
//              width: MediaQuery.of(context).size.width * 0.9,
                alignment: Alignment(-offset.abs(), 0),
                fit: BoxFit.fill,
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
