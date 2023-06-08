import 'package:flutter/material.dart';
// ignore: must_be_immutable
class ConverScreen extends StatelessWidget {
  bool hasGamestarted;
   ConverScreen({
    super.key,
    required this.hasGamestarted
    });

  @override
  Widget build(BuildContext context) {
    return hasGamestarted?Container():Container(
      alignment: Alignment(0,-0.2),
      child: const Text(
        'TAP TO PLAY',
        style: TextStyle(
          fontSize: 20,
          color: Colors.deepPurple,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}