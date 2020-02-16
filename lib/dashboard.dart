import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intmpc/circular_indicator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'classes/countdown.dart';
import 'classes/custom_button.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;

import 'package:http/http.dart' as http;

import 'classes/tips.dart';
import 'classes/web_image_picker.dart';

//TODO: Make List to add widgets to column.
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String userEmail;
  double entries = 0;
  int userImage = 0;
  var data;
  String userName;
  Image image;
  String url = 'https://i.ibb.co/0sd5hdb/b457fb8d2496.png';
  String base64Image;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    getUserName();
    print(userName);
    streamTest();
    super.initState();
  }

  void streamTest() async {
    final response =
        await http.get('http://worldtimeapi.org/api/timezone/Asia/Kolkata');
    print(jsonDecode(response.body));
    setState(() {
      _currentTime = DateTime.parse(jsonDecode(response.body)['utc_datetime']);
    });
    print(_currentTime);
    await fb
        .firestore()
        .collection('images')
        .where('user', '==', 'google.com')
        .onSnapshot
        .forEach((snapshot) {
      snapshot.docs.forEach((data) {
        print(data.data());
      });
    });
  }

  Future<void> getImage() async {
    var tempImage = await FlutterWebImagePicker.getImage;
    setState(() {
      image = tempImage[0];
      base64Image = tempImage[1];
    });
  }

  Future<void> startUpload() async {
    print(base64Image);
    http.post(
        'https://api.imgbb.com/1/upload?key=142055a16fde09fbe596c9336989f15e',
        body: {
          "image": base64Image,
        }).then((res) async {
      print(res.statusCode);
      print(res.body);
      Map body = jsonDecode(res.body);
      setState(() {
        entries--;
        url = body['data']['display_url'];
      });
      await fb
          .firestore()
          .collection('images')
          .add({'url': url, 'user': userEmail, 'likes': 0, 'score': 0});
      print(url);
      await fb.firestore().collection('users').doc(userEmail).update(
        data: {'entries': entries},
      );
    }).catchError((err) {
      print(err);
    });
  }

  Future<void> uploadImage() async {
    bool isLoading = false;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: AlertDialog(
            title: Text(
              'Let\'s Upload',
              style: TextStyle(color: Colors.black, fontFamily: 'George'),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            backgroundColor: Colors.white,
            content: Center(
                child: image != null
                    ? image
                    : Text(
                        'No image selected',
                        style: TextStyle(color: Colors.black),
                      )),
            actions: <Widget>[
              CustomButton(
                text: 'Cancel',
                method: () {
                  Navigator.of(context).pop();
                },
              ),
              CustomButton(
                text: 'Upload',
                method: () {
                  if (entries != 0) {
                    setState(() {
                      isLoading = true;
                    });
                    startUpload();
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.of(context).pop();
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> getUserName() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    userEmail = (await _auth.currentUser()).email;
    data = await fb
        .firestore()
        .collection('users')
        .doc(userEmail)
        .get()
        .then((onValue) {
      return onValue.data();
    });
    setState(() {
      print(data);
      print(data['name']);
      userName = data['name'];
      entries = data['entries'];
      userImage = data['dp'];
      print("Username is $userName");
    });
  }

  _countdownTimer(Duration duration) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/whiteBg.png'), fit: BoxFit.fill),
        ),
        child: Center(
          child: CountdownFormatted(
            onFinish: () {
              print('finished');
            },
            duration: duration,
            builder: (BuildContext ctx, String remaining) {
              return Card(
                elevation: 20.0,
                color: Colors.grey.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                child: Container(
                  width: 370.0,
                  height: 200.0,
                  child: Center(
                    child: Text(
                      remaining,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'George',
                          fontSize: 60.0,
                          color: Colors.black),
                    ),
                  ),
                ),
              ); // 01:00:00
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var difference = _currentTime.difference(
      DateTime.parse('2020-02-25 00:00:00.00'),
    );
//  Use while testing dashboard
//    var difference = now.difference(
//      DateTime.parse('2020-01-11 12:13:00.00'),
//    );
    print(difference);
    return /*-difference.inSeconds > 0
        ? _countdownTimer(-difference)
        :
        */Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height, //this is temporary
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/whiteBg.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width >= 700.0
                      ? MediaQuery.of(context).size.height
                      : 775.0,
                  child: Card(
                    margin: EdgeInsets.all(8.0),
                    elevation: 8.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://firebasestorage.googleapis.com/v0/b/intmpc2020.appspot.com/o/$userImage.png?alt=media",
                            ),
                            radius: 30.0,
                          ),
                          Text(
                            'Welcome $userName!',
                            style: TextStyle(
                              fontFamily: 'George',
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width >= 700.0
                      ? MediaQuery.of(context).size.height
                      : 775.0,
                  child: Card(
                    margin: EdgeInsets.all(8.0),
                    elevation: 8.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          bottomLeft: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0),
                          topRight: Radius.circular(68.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Tips by winners',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'George'),
                                ),
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Tips(
                                    name: '- Angela Manalili : 1st ranker',
                                    network: 'https://i.ibb.co/c8j795B/angmana.jpg',
                                    text: '- Keep your eyes open: you never know when you’ll come across that winning image. \n\n- Don’t be afraid to put yourself out there. Take a risk & enter the contest. I almost didn’t submit an entry \n\n- I didn’t believe my images would be good enough to win. You can’t win if you don’t enter! \n\n- Keep practicing & experiment with different camera settings and post-processing techniques. Think outside the box & be creative.',
                                  ),
                                  SizedBox(
                                    width: 12.0,
                                  ),
                                  Tips(
                                    name: '- Alina Dotsenko : 2nd ranker',
                                    network: 'https://i.ibb.co/tqzXGbH/alina.jpg',
                                    text: 'First of all, believe in yourself and send your photos to participate in the contest. Perhaps you already have ready-made photos or are just going to take photos, choose the best ones, consult with your friends, as it often happens that the majority will choose a completely different photo than you thought. \nAnd most important, remember that great photograph is about interesting light, color and composition. The subject may be simple, but light can create an atmosphere, turn an object into something magical or unusual. In my macro photography I often use additional light sources and some shiny backgrounds to create bokeh, I focus on the details and planning composition. I wish you all good luck and may the light be with you.',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CircularPercentIndicator(
                            radius: 90.0,
                            lineWidth: 7.0,
                            animation: true,
                            percent: entries / 3,
                            circularStrokeCap: CircularStrokeCap.round,
                            footer: Text(
                              'Entries Remaning',
                              style: TextStyle(
                                  color: Colors.grey, fontFamily: 'George'),
                            ),
                            center: Text(
                              "$entries",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30.0,
                              ),
                            ),
                            progressColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomButton(
                      text: 'SUBMIT',
                      tag: 'button1',
                      method: () async {
                        await getImage();
                        uploadImage();
                      },
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    CustomButton(
                      tag: 'button2',
                      method: (){
                        Navigator.pushNamed(context, '/rules');
                      },
                      text: 'Rules',
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    CustomButton(
                      tag: 'button3',
                      text: 'Results',
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        gradient: new LinearGradient(
                            colors: [
                              Colors.black12,
                              Colors.black,
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 1.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      width: 100.0,
                      height: 1.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Your submissions',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'George',
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    //TODO: Change here
                    Container(
                      decoration: BoxDecoration(
                        gradient: new LinearGradient(
                            colors: [
                              Colors.black,
                              Colors.black12,
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 1.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      width: 100.0,
                      height: 1.0,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    StreamBuilder<fs.QuerySnapshot>(
                      stream: fb
                          .firestore()
                          .collection('images')
                          .where('user', '==', userEmail)
                          .onSnapshot,
                      builder: (context, snapshot) {
                        List<Container> urlWidgets = [];
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.grey,
                            ),
                          );
                        }
                        final url = snapshot.data.docs;
                        url.forEach((data) {
                          final urlText = data.data()['url'];
                          final urlWidget = Container(
                            margin: EdgeInsets.all(12.0),
                            width: 110,
                            height: 110,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.network(
                                urlText,
                                fit: BoxFit.fill,
                                loadingBuilder: (context, child, progress) {
                                  return progress == null
                                      ? child
                                      : Center(
                                          child: LinearProgressIndicator(
                                            value:
                                                progress.cumulativeBytesLoaded /
                                                    progress.expectedTotalBytes,
                                          ),
                                        );
                                },
                              ),
                            ),
                          );
                          urlWidgets.add(urlWidget);
                        });
                        return Row(
                          children: urlWidgets,
                        );
                      },
                    ),
                    Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
