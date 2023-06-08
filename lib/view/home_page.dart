import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_build_ball_game/view/my_ball.dart';
import 'package:flutter_build_ball_game/view/my_brick.dart';
import 'package:flutter_build_ball_game/view/my_player.dart';
import 'cover_screen.dart';
import 'game_over_screen.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

// ignore: camel_case_types
enum direction {UP,DOWN,LEFT,RIGHT}
class _HomePageState extends State<HomePage> {
  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.LEFT;

  // ball varible
  double ballX = 0.02;
  double ballY = 0.01;
  // player varible
  double playerX=-0.2;
  double playerWidth=0.6;
  // setting game start
  bool hasGamestarted=false;
  // Check Game Over
  bool isGameOver=false;
  // Brick variable
  static double firstBrickX=-1+wallGrap;
  static double fristBrickY=-0.9;
  static double brickX=0;
  static double birckY=-0.9;
  static double brickWidth=0.4;
  static double brickHeight=0.05;
  static double numberOfBrickInrow=3;
  static double brickGrap=0.2;
  static double wallGrap=0.5 * 
                (2 - 
                  numberOfBrickInrow * brickWidth - 
                  (numberOfBrickInrow-1) * brickGrap);
   // check brick broken
  //bool brickBroken = false;
  List myBricks = [
    //[ x , y , true/false]
    [firstBrickX+ 0 * (brickWidth+brickGrap), fristBrickY, false],
    [firstBrickX+ 1 * (brickWidth+brickGrap), fristBrickY, false],
    [firstBrickX+ 2 * (brickWidth+brickGrap), fristBrickY, false],

  ];
  //....
  double ballXincrements =0.01;
  double ballYincrements =0.01;
 
  // move player to left
  void moveLeft(){
    setState(() {
      if((playerX-0.1 >=-1)){
        playerX-=0.4;
      }
    });
  }
  // move player to right
  void moveRight(){
    setState(() {
      if(!(playerX+playerWidth >=1)){
        playerX+=0.4;
      }
    });
  }
  void startGame(){
    hasGamestarted=true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      //update ball direction
      updateDirection();
      //move ball
      moveBall();
      //chech the player die
      if(isPlayerDead()){
        timer.cancel();
        isGameOver=true;
      }

      //check for broken brick
      checkForBrokenBrick();
     });
  }

  void resetGame(){
    setState(() {
      playerX=-0.2;
      ballX=0;
      ballY=0;
      isGameOver=false;
      hasGamestarted=false;
      myBricks = [
        //[ x , y , true/false]
        [firstBrickX+ 0 * (brickWidth+brickGrap), fristBrickY, false],
        [firstBrickX+ 1 * (brickWidth+brickGrap), fristBrickY, false],
        [firstBrickX+ 2 * (brickWidth+brickGrap), fristBrickY, false],
      ];

    });
  }

  void checkForBrokenBrick(){
    for(int i=0; i<myBricks.length;i++){
      if(
      ballX >= myBricks[i][0] &&
      ballX <= myBricks[i][0] + brickWidth &&
      ballY <= myBricks[i][1] + brickHeight &&
      myBricks[i][2] == false
    ){
      setState(() {
        myBricks[i][2]=true;
        // since brick is broken , update direction of ball
        // base on which side of the brick it hit
        // to do this, calbulate the distance of the ball from each of the 4 sides
        // the smallest distance is the side the ball has it
        double leftSideDist = (myBricks[i][0] - ballX).abs();
        double rightSideDist = (myBricks[i][0] - brickWidth + ballX).abs();
        double topSideDist = (myBricks[i][1] - ballY).abs();
        double bottomSideDist = (myBricks[i][1] - brickHeight - ballY).abs();

        String min = findMin(leftSideDist,rightSideDist,topSideDist,bottomSideDist);
        switch(min){
          case 'left':
            ballXDirection = direction.LEFT;
          break;
          case 'right':
            ballXDirection = direction.LEFT;
          break;
          case 'up':
            ballYDirection = direction.UP;
          break;
          case 'down':
            ballYDirection = direction.DOWN;
          break;
        }



        ballYDirection = direction.DOWN;
      });
    }
    }
  }
  // return the smallest
  String findMin(double a,double b,double c, double d){
    List<double> myList = [
        a,
        b,
        c,
        d
    ];
    double currentMin=0;
    for(int i=0; i<myList.length;i++){
      if(myList[i] < currentMin){
        currentMin=myList[i];
      }
    }

    if((currentMin - a).abs() < 0.01){
      return 'left';
    }else if((currentMin - b).abs() < 0.01){
      return 'right';
    }else if((currentMin - c).abs() < 0.01){
      return 'top';
    }else if((currentMin - d).abs() < 0.01){
      return 'bottom';
    }
    return '';
  }
  // Check Game Over
  bool isPlayerDead(){
    if(ballY>=1){
      return true;
    }
    return false;
  }

  void updateDirection(){
    setState(() {
      // when ball goes up when it hit player
      if(ballY>=0.9 && ballX >= playerX && ballX <= playerX+playerWidth){
        ballYDirection = direction.UP;
      // when ball goes down when it hit the top of screen
      }else if(ballY<=-1){
        ballYDirection = direction.DOWN;
      }

      // ball goes left when hit the wall
      if(ballX >= 1){
        ballXDirection = direction.LEFT;
      // ball goes right when hit the wall
      }else if(ballX <=-1){
        ballXDirection = direction.RIGHT;
      }
      

    });
  }
  void moveBall(){
    setState(() {
      // Move Horithital
      if(ballXDirection == direction.LEFT){
        ballX-=ballXincrements;
      }else if(ballXDirection == direction.RIGHT){
        ballX+=ballXincrements;
      }

      // Move Vertical
      if(ballYDirection == direction.DOWN){
        ballY+=ballYincrements;
      }else if(ballYDirection == direction.UP){
        ballY-=ballYincrements;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode:FocusNode(),
      autofocus: true,
      onKey: (event) {
        if(event.isKeyPressed(LogicalKeyboardKey.arrowLeft)){
          moveLeft();
        }else if(event.isKeyPressed(LogicalKeyboardKey.arrowRight)){
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          body: Center(
            child: Stack(
              children: [
                // tap to play
                ConverScreen(
                  hasGamestarted: hasGamestarted,
                ),
                //ball
                MyBall(
                  hasGamestarted: hasGamestarted,
                  isGameOver: isGameOver,
                  ballX: ballX,
                  ballY: ballY,
                ),

                // Game Over
                GameOverScreen(
                  function: resetGame,
                  isGameOver: isGameOver,
                ),
                // My Player
                MyPlayer(
                  playerWidth: playerWidth,
                  playerX: playerX,
                ),
                // Where is PlayerX acaxtly
                /*
                Container(
                  alignment: Alignment(playerX,0.9),
                  child: Container(
                    height: 15,
                    width: 10,
                    color: Colors.red,
                  ),
                ),

                Container(
                  alignment: Alignment(playerX+playerWidth,0.9),
                  child: Container(
                    height: 15,
                    width: 10,
                    color: Colors.green,
                  ),
                )
                */
                // show the brick
                MyBrick(
                  brickHeight: brickHeight,
                  brickWidth: brickWidth,
                  brickX: myBricks[0][0],
                  brickY: myBricks[0][1],
                  brickBroken: myBricks[0][2],
                ),
                MyBrick(
                  brickHeight: brickHeight,
                  brickWidth: brickWidth,
                  brickX: myBricks[1][0],
                  brickY: myBricks[1][1],
                  brickBroken: myBricks[1][2],
                ),
                MyBrick(
                  brickHeight: brickHeight,
                  brickWidth: brickWidth,
                  brickX: myBricks[2][0],
                  brickY: myBricks[2][1],
                  brickBroken: myBricks[2][2],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}