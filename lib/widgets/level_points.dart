import 'package:flutter/material.dart';

class LevelPoints extends StatelessWidget {
  final Color containerColor;

  const LevelPoints({ this.containerColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: containerColor,
      ),
    );
  }
}