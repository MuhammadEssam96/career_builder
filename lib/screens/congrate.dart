import 'package:flutter/material.dart';
class Congrate extends StatelessWidget {
  var question1Result;
  var question2Result;
  // Congrate(this.question1Result,this.question2Result);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('your result'),),
      body: Container(
      child: Column(children: <Widget>[
        Text(question1Result)
      ],)
    ),
    );
  }
}