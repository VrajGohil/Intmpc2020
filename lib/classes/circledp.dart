import 'package:flutter/material.dart';

class CircleDp extends StatelessWidget {
  CircleDp({this.address, this.name});
  final String address;
  final String name;
  @override
//  radius: MediaQuery.of(context).size.height * 0.07,
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(new PageRouteBuilder(
                    opaque: false,
                    barrierDismissible: true,
                    pageBuilder: (BuildContext context, _, __) {
                      return Material(
                        color: Colors.redAccent.withOpacity(0.0),
                        child: InkWell(
                          onTap: () {
                            print("click");
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: Material(
                                color: Colors.redAccent.withOpacity(0.0),
                                child: InkWell(
                                  onTap: () {
                                    print("click");
                                    Navigator.pop(context);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Center(
                                        child: Text(
                                          name,
                                          style: TextStyle(
                                              fontFamily: 'George',
                                              color: Colors.black),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Hero(
                                        tag: name,
                                        child: CircleAvatar(
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          backgroundImage: AssetImage(address),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      );
                    }));

//                showDialog(
//                    context: context,
//                    builder: (BuildContext context) {
//                      return Hero(
//                        tag: name,
//                        child: AlertDialog(
//                          title: Text(
//                            name,
//                            style: TextStyle(
//                                color: Colors.black, fontFamily: 'George'),
//                          ),
//                          backgroundColor: Colors.white,
//                          shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(16.0),
//                          ),
//                          content: Center(
//                            child: CircleAvatar(
//                              maxRadius:
//                                  MediaQuery.of(context).size.height * 0.15,
//                              backgroundImage: AssetImage(address),
//                            ),
//                          ),
//                        ),
//                      );
//                    });
              },
              child: Hero(
                tag: name,
                child: CircleAvatar(
                  backgroundImage: AssetImage(address),
//              radius: 38.0,
                  radius: MediaQuery.of(context).size.height <= 600.0
                      ? MediaQuery.of(context).size.height * 0.07
                      : 38.0,
                ),
              ),
            ),
            margin: EdgeInsets.all(12.0),
          ),
        ),
        Container(
          child: Text(
            name,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'George',
            ),
          ),
        ),
      ],
    );
  }
}
