import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: const Center(
            child: Text(
              "This is error page",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
        ));
  }
}
