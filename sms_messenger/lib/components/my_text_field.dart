import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool isObscureText;
  final TextEditingController controller;

  MyTextField(
      {required this.hintText,
      required this.isObscureText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      controller: this.controller,
      obscureText: isObscureText,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.white)),
          hintText: this.hintText),
    );
  }
}
