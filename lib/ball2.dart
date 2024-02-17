import 'package:flutter/material.dart';

class MyBall2 extends StatelessWidget {
  final ball2X;
  final ball2Y;

  MyBall2({this.ball2X, this.ball2Y});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(ball2X, ball2Y),
        child: Container(
          height: 15,
          width: 15,
          color: Colors.black,
        ));
  }
}
