import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final Color buttonColor;
  final String buttonText;
  final Function buttonOnPressed;

  const AnswerButton({this.buttonColor, this.buttonText, this.buttonOnPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: buttonColor,
      shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(30.0))),
      child: Text(
        buttonText,
        style: TextStyle(
          color: buttonColor == Colors.white ? Colors.black : Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      ),
      onPressed: buttonOnPressed
    );
  }
}