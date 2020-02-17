import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  StatCard({this.numdata, this.type});
  final String numdata;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 16.0,
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 58.0,
//            width: 100.0,
            width: MediaQuery.of(context).size.width >= 650.0
                ? 100
                : MediaQuery.of(context).size.width * 0.25,
            child: Center(
              child: Text(numdata,
                  style: TextStyle(
//                    fontSize: 40.0,
                    fontSize: MediaQuery.of(context).size.height >= 650.0
                        ? 40
                        : 30,
                    fontFamily: 'George',
                  ),
                ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text( type,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'George',
              ),
            ),
          )
        ],
      ),
    );
  }
}
