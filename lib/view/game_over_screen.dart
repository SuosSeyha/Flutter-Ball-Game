import 'package:flutter/material.dart';
class GameOverScreen extends StatelessWidget {
  bool isGameOver;
  final function;
  GameOverScreen({super.key, 
    required this.isGameOver,
    required this.function
  });

  @override
  Widget build(BuildContext context) {
    return isGameOver ? Container(
      alignment: const Alignment(0,0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
          margin: const EdgeInsets.only(
            bottom: 20
          ),
          alignment: const Alignment(0,-0.3),
          child: const Text(
            'G A M E O V E R'
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: function,
              child: GestureDetector(
                onTap:function,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10
                  ),
                  alignment: const Alignment(0,-0.3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10
                    ),
                    color: Colors.deepPurple
                  ),
                  child: const Text(
                    'PLAY AGAIN',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        ],
      ),
    )
     : Container();
  }
}