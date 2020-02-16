import 'package:flutter/material.dart';

class Tips extends StatelessWidget {
  Tips({this.network,this.text,this.name});
  final String network;
  final String text;
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: CircleAvatar(
        radius: 26.0,
        backgroundImage: NetworkImage(network),
      ),
      onTap: () async {
        return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36.0)),
              content: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircleAvatar(
                        radius: 36.0,
                        backgroundImage: NetworkImage(network),
                      ),
                    ),
                    Container(
                      child: Text(text,style: TextStyle(fontFamily: 'George',color: Colors.black, fontSize: 14.0), textAlign: TextAlign.justify,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        child: Text(name,style: TextStyle(fontFamily: 'George',color: Colors.black),),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}