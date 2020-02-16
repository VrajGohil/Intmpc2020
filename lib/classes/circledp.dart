import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleDp extends StatelessWidget {
  CircleDp({this.address, this.name, this.network, this.color = Colors.black});
  final String address;
  final String name;
  final String network;
  final Color color;
  ImageProvider getImage() {
    if (address != null) {
      return AssetImage(address);
    } else {
      return NetworkImage(network);
    }
  }

  @override
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
                            color: Colors.white.withOpacity(0.7),
                            alignment: Alignment.center,
                            child: Material(
                                color: Colors.redAccent.withOpacity(0.0),
                                child: InkWell(
                                  onTap: () {
                                    print("click");
                                    Navigator.pop(context);
                                  },
                                  child: Hero(
                                    tag: name,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        radius: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.20,
                                        backgroundImage: getImage(),
                                      ),
                                    ),
                                  ),
                                ),),
                          ),
                        ),
                      );
                    }));
              },
              child: Hero(
                tag: name,
                child: CircleAvatar(
                  backgroundImage: getImage(),
//              radius: MediaQuery.of(context).size.width * 0.1,
                  radius: MediaQuery.of(context).size.height * 0.043,
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
              color: color,
              fontFamily: 'George',
              fontSize: MediaQuery.of(context).size.height >= 650.0
                  ? 15.0
                  : 10.0,
            ),
          ),
        ),
      ],
    );
  }
}
