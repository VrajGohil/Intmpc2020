import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;

class Jury extends StatefulWidget {
  final String email;
  final List<String> juryList;
  Jury({@required this.email, @required this.juryList});
  @override
  _JuryState createState() => _JuryState();
}

class _JuryState extends State<Jury> {
  @override
  Widget build(BuildContext context) {
    return widget.juryList.contains(widget.email)
        ? Scaffold(
            body: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Welcome Jury!',
                        style: TextStyle(
                            fontFamily: 'George',
                            color: Colors.black,
                            fontSize: 24.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'This is the first round for judging. Select either ✔️ or ❌, the selected entries would be eligible for 2nd round. After making the decision, that particular image would disappear from the feed. Our aim is to judge all the entries.',
                        style: TextStyle(
                            fontFamily: 'George', color: Colors.black),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    StreamBuilder<fs.QuerySnapshot>(
                      stream: fb
                          .firestore()
                          .collection('images')
                          .where(widget.email[0], '==', 'non')
                          .onSnapshot,
                      builder: (context, snapshot) {
                        print(widget.email[0]);
                        List<Column> urlWidgets = [];
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
                          print(data.id);
                          //Todo uncomment below to use firebase for images
                          //final urlText = data.data()['urlFirebase'];
                          final urlWidget = Column(
                            children: <Widget>[
                              SizedBox(
                                height: 20.0,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Container(
                                  child: Image.network(
                                    urlText,
                                    fit: BoxFit.fill,
                                    loadingBuilder: (context, child, progress) {
                                      return progress == null
                                          ? child
                                          : Center(
                                              child: LinearProgressIndicator(
                                                value: progress
                                                        .cumulativeBytesLoaded /
                                                    progress.expectedTotalBytes,
                                              ),
                                            );
                                    },
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                      onPressed: () async {
                                        print('like');
                                        var docLocation = data.id;
                                        print(docLocation);
                                        var firebaseData = await fb
                                            .firestore()
                                            .collection('images')
                                            .doc(docLocation)
                                            .get()
                                            .then((onValue) {
                                          return onValue.data();
                                        });
                                        await fb
                                            .firestore()
                                            .collection('images')
                                            .doc(docLocation)
                                            .update(
                                          data: {widget.email[0]: 'true','likes': firebaseData['likes'] + 1},
                                        );
                                      },
                                      icon: Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 28.0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                      onPressed: () async {
                                        print('dislike');
                                        var docLocation = data.id;
                                        print(docLocation);
                                        await fb
                                            .firestore()
                                            .collection('images')
                                            .doc(docLocation)
                                            .update(
                                          data: {widget.email[0]: 'false'},
                                        );
                                      },
                                      icon: Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                        size: 28.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                width: double.infinity,
                                height: 2.0,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ],
                          );
                          urlWidgets.add(urlWidget);
                        });
                        return urlWidgets.isNotEmpty
                            ? Column(
                                children: urlWidgets,
                              )
                            : Column(
                              children: <Widget>[
                                Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Well done!\n No entries left to judge',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 36.0, fontFamily: 'George',color: Colors.black),
                                      ),
                                    ),
                                  ),
                              ],
                            );
                      },
                    ),
                    Container(),
                  ],
                ),
              ),
            ),
          )
        // If user is not jury
        : Text('unauthorized to access this page');
  }
}
