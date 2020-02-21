import 'package:flutter/material.dart';

class CustomTextCard extends StatelessWidget {
  CustomTextCard({@required this.text,this.number});
  final String text;
  final String number;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child: Card(
            elevation: 24.0,
            color: Colors.grey.withOpacity(0.2),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                number,
                style: TextStyle(color: Colors.white, fontFamily: 'George',fontSize: MediaQuery.of(context).size.height < 650 ? 18.0 : 22.0),
              ),
            ),
          ),
        ),
        Container(
//          width: MediaQuery.of(context).size.width * 0.95,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Card(
                elevation: 24.0,
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(
                      text,
                      style: TextStyle(color: Colors.white.withOpacity(0.8), fontFamily: 'George',fontSize: MediaQuery.of(context).size.height < 650 ? 10.0 : 14.0),
                    ),
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
