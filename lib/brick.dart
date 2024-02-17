import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  final brickX;
  final brickY;
  final brickHight;
  final brickWidth;
  final bool brickCollision;

  MyBrick(
      {this.brickHight,
      this.brickWidth,
      this.brickX,
      this.brickY,
      required this.brickCollision});
  @override
  Widget build(BuildContext context) {
    return brickCollision
        ? Container(
            // alignment: Alignment(brickX, brickY),
            // child: Container(
            //   height: MediaQuery.of(context).size.height * brickHight / 2,
            //   width: MediaQuery.of(context).size.height * brickWidth / 2,
            //   color: Colors.blue,
            // ),
            )
        : Container(
            alignment: Alignment(brickX, brickY),
            child: Container(
              height: MediaQuery.of(context).size.height * brickHight / 2,
              width: MediaQuery.of(context).size.height * brickWidth / 2,
              color: Colors.black,
            ),
          );
  }
}
