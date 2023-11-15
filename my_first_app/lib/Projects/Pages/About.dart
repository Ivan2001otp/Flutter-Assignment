import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: const Center(
            child: Text(
              "About Us",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
            ),
          ),
        ));
  }
}
