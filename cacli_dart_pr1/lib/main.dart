import 'dart:ffi';

import 'package:cacli_dart/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  var input = '';
  var output = "0";
  double result = 0.0;

  bool isOperator(String ch) {
    if (ch == '+' ||
        ch == '-' ||
        ch == '/' ||
        ch == '-' ||
        ch == '.' ||
        ch == '*') return false;

    return true;
  }

  void onButtonClick(selectedValue) {
    switch (selectedValue) {
      case 'AC':
        input = '';
        output = "0";
        break;

      case '<':
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
        }
        break;

      case '=':
        if (input.isNotEmpty && isOperator(input[input.length - 1])) {
          var userInput = input;
          userInput = userInput.replaceAll('X', "*");
          Parser p = Parser();
          Expression expression = p.parse(userInput);
          ContextModel contextModel = ContextModel();
          output =
              expression.evaluate(EvaluationType.REAL, contextModel).toString();
        }
        break;

      default:
        input = input + selectedValue; //str;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          title: Text(
            'Calci-Dart',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
        backgroundColor: Colors.black12,
        body: Column(children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    output,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.74),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              button(textValue: 'AC', buttonBgColor: orangeColor),
              button(
                  textValue: '<',
                  buttonBgColor: Colors.white,
                  textColor_: Colors.black),
              button(
                  textValue: '',
                  textColor_: orangeColor,
                  buttonBgColor: operatorColor),
              button(
                  textValue: '/',
                  textColor_: orangeColor,
                  buttonBgColor: operatorColor)
            ],
          ),
          Row(
            children: [
              button(textValue: '7'),
              button(textValue: '8'),
              button(textValue: '9'),
              button(
                  textValue: '*',
                  textColor_: orangeColor,
                  buttonBgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(textValue: '6'),
              button(textValue: '5'),
              button(textValue: '4'),
              button(
                  textValue: '-',
                  textColor_: orangeColor,
                  buttonBgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(textValue: '3'),
              button(textValue: '2'),
              button(textValue: '1'),
              button(
                  textValue: '+',
                  textColor_: orangeColor,
                  buttonBgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(
                  textValue: '%',
                  textColor_: orangeColor,
                  buttonBgColor: operatorColor),
              button(textValue: '0'),
              button(
                  textValue: '.',
                  textColor_: orangeColor,
                  buttonBgColor: operatorColor),
              button(textValue: '=', buttonBgColor: orangeColor),
            ],
          )
        ]));
  }

  Widget button(
      {textValue, textColor_ = Colors.white, buttonBgColor = buttonColor}) {
    return Expanded(
        child: Container(
      height: 60,
      width: 45,
      margin: EdgeInsets.all(8),
      child: ElevatedButton(
          onPressed: () {
            onButtonClick(textValue);
          },
          style: ElevatedButton.styleFrom(
              side: BorderSide(
                  color: Colors.grey, width: 1, style: BorderStyle.solid),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              backgroundColor: buttonBgColor),
          child: Text(
            textValue,
            style: TextStyle(
                color: textColor_, fontSize: 25, fontWeight: FontWeight.bold),
          )),
    ));
  }
}
