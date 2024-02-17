import 'dart:async';
import 'package:flutter/material.dart';
import 'coverscreen.dart';
import 'ball1.dart';
import 'brick.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum direction { UP, DOWN }

class _HomePageState extends State<HomePage> {
//ball var
  double ball1X = 0;
  double ball1Y = 0;

  var ballDirection = direction.DOWN;

  //brick var
  double brickX = 0;
  double brickY = -0.9;
  double brickHight = 0.05;
  double brickWidth = 0.4;
  bool brickCollision = false;
  // game setting
  bool hasGameStarted = false;

  void startGame() {
    hasGameStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      //update direction
      updateDirection();

      // move ball
      moveBall();

      // chack if break is hit
      cheakForHitBricks();
    });
  }

  void cheakForHitBricks() {
    if (ball1X >= brickX &&
        ball1Y <= brickY + brickWidth &&
        ball1Y <= brickY + brickHight &&
        brickCollision == false) {
      setState(() {
        brickCollision = true;
        ballDirection = direction.DOWN;
      });
    }
  }

  void moveBall() {
    setState(() {
      if (ballDirection == direction.DOWN) {
        ball1Y += 0.01;
      } else if (ballDirection == direction.UP) {
        ball1Y -= 0.01;
      }
    });
  }

// update direction
  void updateDirection() {
    setState(() {
      if (ball1Y >= 1) {
        ballDirection = direction.UP;
      } else if (ball1Y <= -1) {
        ballDirection = direction.DOWN;
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
