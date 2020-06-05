import 'package:flutter/material.dart';

class Congrate extends StatefulWidget {
  @override
  _CongrateState createState() => _CongrateState();
}

class _CongrateState extends State<Congrate> {
  var question1Result;
  var question2Result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('your result')
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(question1Result)
          ],
        )
      ),
    );
  }
}