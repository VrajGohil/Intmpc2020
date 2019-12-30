import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intmpc/circular_indicator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'classes/custom_button.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';
import 'package:http/http.dart' as http;

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
  List<Widget> submission = [SizedBox()];

  @override
  void initState() {
    getUserName();
    print(userName);
    super.initState();
  }

  Future<void> getImage() async {
    var tempImage = await FlutterWebImagePicker.getImage;
    setState(() {
      image = tempImage[0];
      base64Image = tempImage[1];
    });
  }

  Future<void> startUpload() async{
    print(base64Image);
    http.post(
        'https://api.imgbb.com/1/upload?key=6b908e80517e7a275075491546164b43',
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
          .add({'url': url, 'user': userEmail});
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
                  if(entries != 0){
                    setState(() {
                      isLoading = true;
                    });
                    startUpload();
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.of(context).pop();
                  }
                  else{
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

  Future<void> getEntries() async {
    await fb
        .firestore()
        .collection('images')
        .where('user', '==', userEmail)
        .get()
        .then((onValue) {
      onValue.forEach((entry) {
        print(entry.data()['url']);
        setState(() {
          submission.add(
            Container(
              margin: EdgeInsets.all(12.0),
              width: 110,
              height: 110,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  entry.data()['url'],
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        });
      });
    });
  }

  Future<void> getUserName() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    userEmail = (await _auth.currentUser()).email;
    if (userEmail == null) {
      Navigator.pushNamed(context, '/login');
    } else {
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
        getEntries();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 800.0, //this is temporary
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/whiteBg.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
//              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Some kind of text here',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              CustomButton(
                                text: 'SUBMIT',
                                method: () async {
                                  await getImage();
                                  uploadImage();
                                },
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
                  children: submission,
                ),
//                Container(
//                  margin: EdgeInsets.all(20.0),
//                  width: 450,
//                  height: 200,
//                  child: ClipRRect(
//                    borderRadius: BorderRadius.circular(16.0),
//                    child: Image.asset(
//                      'assets/blackBg.png',
//                      fit: BoxFit.fill,
//                    ),
//                  ),
//                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
