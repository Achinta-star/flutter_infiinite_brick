import 'dart:async';
import 'package:flutter/material.dart';
import 'coverscreen.dart';
import 'ball1.dart';
import 'ball2.dart';
import 'brick.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum direction1 { UP1, DOWN1, LEFT1, RIGHT1 }

enum direction2 { UP2, DOWN2, LEFT2, RIGHT2 }

class _HomePageState extends State<HomePage> {
//ball var
  double ball1X = 0.1;
  double ball1Y = 0;
  double ball1Xincrements = 0.01;
  double ball1Yincrements = 0.01;
  var ball1YDirection = direction1.DOWN1;
  var ball1XDirection = direction1.LEFT1;

  double ball2X = -0.3;
  double ball2Y = 0;
  double ball2Xincrements = 0.01;
  double ball2Yincrements = 0.01;
  var ball2XDirection = direction2.DOWN2;
  var ball2YDirection = direction2.LEFT2;
  //brick var
  double brickX = 0;
  double brickY = -0.9;
  double brickHight = 0.04;
  double brickWidth = 0.04;

  bool brickCollision = false;
  // game setting
  bool hasGameStarted = false;

  void startGame() {
    hasGameStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      //update direction for ball1
      updateDirection1();

      //update direction for ball2
      updateDirection2();

      // move ball1
      moveBall1();
      // move ball2
      moveBall2();

      // chack if break is hit
      cheakForHitBricks();
    });
  }

  void cheakForHitBricks() {
    if (ball1X >= brickX &&
        ball1X <= brickX + brickWidth &&
        ball1Y <= brickY + brickHight &&
        brickCollision == false) {
      setState(() {
        brickCollision = true;
        ball1YDirection = direction1.DOWN1;
      });
    }
  }

  void moveBall1() {
    setState(() {
      // horizontlly
      if (ball1XDirection == direction1.LEFT1) {
        ball1X -= ball1Xincrements;
      } else if (ball1XDirection == direction1.RIGHT1) {
        ball1X += ball1Xincrements;
      }
      // vertically
      if (ball1YDirection == direction1.DOWN1) {
        ball1Y += ball1Yincrements;
      } else if (ball1YDirection == direction1.UP1) {
        ball1Y -= ball1Yincrements;
      }
    });
  }

  void moveBall2() {
    setState(() {
      if (ball2XDirection == direction2.LEFT2) {
        ball2X -= ball2Xincrements;
      } else if (ball2XDirection == direction2.RIGHT2) {
        ball2X += ball2Xincrements;
      }

      if (ball2YDirection == direction2.DOWN2) {
        ball2Y += ball2Yincrements;
      } else if (ball2YDirection == direction2.UP2) {
        ball2Y -= ball2Yincrements;
      }
    });
  }

// update direction
  void updateDirection1() {
    setState(() {
      if (ball1Y >= 1) {
        ball1YDirection = direction1.UP1;
      } else if (ball1Y <= -1) {
        ball1YDirection = direction1.DOWN1;
      } else if (ball1X >= 1) {
        ball1XDirection = direction1.LEFT1;
      } else if (ball1X <= -1) {
        ball1XDirection = direction1.RIGHT1;
      }
    });
  }

  void updateDirection2() {
    setState(() {
      if (ball2Y >= 1) {
        ball2YDirection = direction2.UP2;
      } else if (ball2Y <= -1) {
        ball2YDirection = direction2.DOWN2;
      } else if (ball2X >= 1) {
        ball2XDirection = direction2.LEFT2;
      } else if (ball2X <= -1) {
        ball2XDirection = direction2.RIGHT2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: startGame,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Stack(
            children: [
              //cover
              CoverScreen(hasGameStarted: hasGameStarted),

              // ball
              MyBall1(
                ball1X: ball1X,
                ball1Y: ball1Y,
              ),
              MyBall2(
                ball2X: ball2X,
                ball2Y: ball2Y,
              ),

              //bricks
              MyBrick(
                brickX: brickX,
                brickY: brickY,
                brickHight: brickHight,
                brickWidth: brickWidth,
                brickCollision: brickCollision,
              )
            ],
          ),
        ),
      ),
    );
  }
}
