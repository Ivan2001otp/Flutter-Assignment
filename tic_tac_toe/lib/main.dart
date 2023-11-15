import 'package:flutter/material.dart';
import 'package:tic_tac_toe/Screens/game.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: myApp(),
  ));
}

class myApp extends StatefulWidget {
  const myApp({super.key});

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    return GameScreen();
  }
}
