import 'package:flutter/material.dart';

class Company extends StatelessWidget {
  final String network;
  final Function onTap;

  Company({Key key, this.network, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          child: Image.network(network,fit: BoxFit.fill,),
          width: MediaQuery.of(context).size.height < 700 ? MediaQuery.of(context).size.height * 0.15 : MediaQuery.of(context).size.height * 0.18,
          height:  MediaQuery.of(context).size.height < 700 ? MediaQuery.of(context).size.height * 0.15 : MediaQuery.of(context).size.height * 0.18),
    );
  }
}