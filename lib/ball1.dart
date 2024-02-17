import 'package:flutter/material.dart';

class MyBall1 extends StatelessWidget {
  final ball1X;
  final ball1Y;

  MyBall1({this.ball1X, this.ball1Y});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(ball1X, ball1Y),
        child: Container(
          height: 15,
          width: 15,
          color: Colors.red,
        ));
  }
}
