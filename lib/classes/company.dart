import 'package:flutter/material.dart';

class Company extends StatelessWidget {
  final String network;
  final Function onTap;

  Company({Key key, this.network, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Container(
            child: Image.network(network,fit: BoxFit.fill,),
            width: MediaQuery.of(context).size.width < 600 ? MediaQuery.of(context).size.width * 0.40 : 240,
            height: MediaQuery.of(context).size.height < 800 ? MediaQuery.of(context).size.height * 0.12 : 120),
        elevation: 8.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      ),
    );
  }
}