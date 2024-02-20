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

class _HomePageState extends State<HomePage> {
// ball var
  double ball1X = 0;
  double ball1Y = 0;
  double ball2X = -0.1;
  double ball2Y = 0;

  double ball1Xincrements = 0.01;
  double ball1Yincrements = 0.01;
  var ball1YDirection = direction1.DOWN1;
  var ball1XDirection = direction1.LEFT1;

  double ball2Xincrements = 0.01;
  double ball2Yincrements = 0.01;
  var ball2YDirection = direction1.DOWN1;
  var ball2XDirection = direction1.LEFT1;

  //brick var
  static double brick1X = -1 + wallGap;
  static double brick1Y = -0.9;
  static double brickHight = 0.04;
  static double brickWidth = 0.04;
  static double brickGap = 0;
  static int numberOfBricksInRow = 3;
  static double wallGap = 0.5 *
      (2 -
          numberOfBricksInRow * brickWidth -
          (numberOfBricksInRow - 1) * brickGap);

  bool brickCollision = false;

  List MyBricks = [
    [brick1X + 0 * (brickWidth + brickGap), brick1Y, false],
    [brick1X + 1 * (brickWidth + brickGap), brick1Y, false],
    [brick1X + 2 * (brickWidth + brickGap), brick1Y, false],
  ];

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
    for (int i = 0; i < MyBricks.length; i++) {
      if (ball1X >= MyBricks[i][0] &&
          ball1X <= MyBricks[i][0] + brickWidth &&
          ball1Y <= MyBricks[i][1] + brickHight &&
          MyBricks[i][2] == false) {
        setState(() {
          MyBricks[i][2] = true;

          double leftSideDist = (MyBricks[i][0] - ball1X).abs();
          double rightSideDist = (MyBricks[i][0] + brickWidth - ball1X).abs();
          double topSideDist = (MyBricks[i][1] - ball1X).abs();
          double bottomSideDist = (MyBricks[i][1] + brickWidth - ball1Y).abs();

          ball1YDirection = direction1.DOWN1;
          ball1YDirection = direction1.UP1;
          ball1YDirection = direction1.LEFT1;
          ball1YDirection = direction1.RIGHT1;
        });
      }
    }
  }

  void moveBall1() {
    setState(() {
      // horizontlly
      // if (ball1XDirection == direction1.LEFT1) {
      //   ball1X -= ball1Xincrements;
      // } else if (ball1XDirection == direction1.RIGHT1) {
      //   ball1X += ball1Xincrements;
      // }
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
      // horizontlly
      // if (ball2XDirection == direction1.LEFT1) {
      //   ball2X -= ball2Xincrements;
      // } else if (ball2XDirection == direction1.RIGHT1) {
      //   ball2X += ball2Xincrements;
      // }
      // vertically
      if (ball2YDirection == direction1.DOWN1) {
        ball2Y += ball2Yincrements;
      } else if (ball2YDirection == direction1.UP1) {
        ball2Y -= ball2Yincrements;
      }
    });
  }

//update direction
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

  //update direction
  void updateDirection2() {
    setState(() {
      if (ball2Y >= 1) {
        ball2YDirection = direction1.UP1;
      } else if (ball2Y <= -1) {
        ball2YDirection = direction1.DOWN1;
      } else if (ball2X >= 1) {
        ball2XDirection = direction1.LEFT1;
      } else if (ball2X <= -1) {
        ball2XDirection = direction1.RIGHT1;
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
                brickX: MyBricks[0][0],
                brickY: MyBricks[0][1],
                brickCollision: MyBricks[0][2],
                brickHight: brickHight,
                brickWidth: brickWidth,
              ),
              MyBrick(
                brickX: MyBricks[1][0],
                brickY: MyBricks[1][1],
                brickCollision: MyBricks[1][2],
                brickHight: brickHight,
                brickWidth: brickWidth,
              ),
              MyBrick(
                brickX: MyBricks[2][0],
                brickY: MyBricks[2][1],
                brickCollision: MyBricks[2][2],
                brickHight: brickHight,
                brickWidth: brickWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
