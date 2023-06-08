import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
class MyBall extends StatelessWidget {
  double ballX;
  double ballY;
  final bool isGameOver;
  final bool hasGamestarted;
   MyBall({
    super.key,
    required this.ballX,
    required this.ballY,
    required this.hasGamestarted,
    required this.isGameOver,
    });

  @override
  Widget build(BuildContext context) {
    return hasGamestarted ? Container(
      //color: Colors.amber,
      alignment: Alignment(ballX, ballY),
      child: Container(
        height: 15,
        width: 15,
        decoration: const BoxDecoration(
          color: Colors.deepPurple,
          shape: BoxShape.circle
        ),
      ),
    ):
    Container(
      //color: Colors.amber,
      alignment: Alignment(ballX, ballY),
      child: AvatarGlow(
        glowColor: Colors.deepPurple,
        shape: BoxShape.circle,
        endRadius: 90.0,
        child: Material(
          elevation: 2,
          shape: const CircleBorder(),
          child: CircleAvatar(
            backgroundColor: Colors.deepPurple,
            child: Container(
              width: 15,
              height: 15,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepPurple
              ),
            ),
          ),
        )
      ),
    );
  }
}