import 'package:flutter/material.dart';

class QuestionText extends StatelessWidget {
  final String qText;
  QuestionText(this.qText);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 15,left: 15,right: 15),
      child: Text(qText,
        style: TextStyle(
          color: Color(0xff8C9496),
          fontSize: 18
        ),
      ),
    );
  }
}