import 'package:flutter/material.dart';
class MyBrick extends StatelessWidget {
  double brickWidth;
  double brickHeight;
  double brickX;
  double brickY;
  bool brickBroken;
  MyBrick({
    required this.brickHeight,
    required this.brickWidth,
    required this.brickX,
    required this.brickY,
    required this.brickBroken
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * brickX + brickWidth) / (2 - brickWidth),brickY),
      child: brickBroken?Container() : 
      ClipRRect(
        borderRadius: BorderRadius.circular(
          5
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * brickHeight/2,
          width: MediaQuery.of(context).size.width*brickWidth/2,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}