import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import './PaintColors/Color_.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: CalculatorUI()));
}

class CalculatorUI extends StatefulWidget {
  @override
  State<CalculatorUI> createState() => CalculatorUIState();
}

class CalculatorUIState extends State<CalculatorUI> {
  var input = '0.0';
  var output = '0.0';
  late double res;

  resultHandler(pressedValue) {
    print(pressedValue);

    if (pressedValue == 'AC') {
      input = '';
    } else if (pressedValue == '<' && !input.isEmpty) {
      input = input.substring(0, input.length - 1);
    } else if (pressedValue == '=' && input.length != 0) {
      var ans = input;
      Parser parser = Parser();
      Expression expression = parser.parse(ans);
      ContextModel cm = ContextModel();
      output = expression.evaluate(EvaluationType.REAL, cm).toString();
    } else {
      if (input == '0.0') input = '';
      input = input + pressedValue;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        title: Text('Practice Calculator'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Container(
              margin: EdgeInsets.all(20),
              width: double.infinity,
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    output,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 35),
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            )),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                children: [
                  ButtonWidget(
                      buttonValue: 'AC',
                      buttonBgColor: orangeColor,
                      textColor: Colors.white),
                  ButtonWidget(
                      buttonValue: '<',
                      buttonBgColor: Colors.white,
                      textColor: Colors.black),
                  ButtonWidget(buttonValue: '', buttonBgColor: Colors.red),
                  ButtonWidget(
                      buttonValue: '/',
                      buttonBgColor: operatorColor,
                      textColor: orangeColor)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                children: [
                  ButtonWidget(
                      buttonValue: '7',
                      buttonBgColor: buttonColor,
                      textColor: Colors.white),
                  ButtonWidget(
                    buttonValue: '8',
                    buttonBgColor: buttonColor,
                  ),
                  ButtonWidget(buttonValue: '9', buttonBgColor: buttonColor),
                  ButtonWidget(
                      buttonValue: '*',
                      buttonBgColor: operatorColor,
                      textColor: orangeColor)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                children: [
                  ButtonWidget(
                    buttonValue: '6',
                  ),
                  ButtonWidget(
                    buttonValue: '5',
                  ),
                  ButtonWidget(
                    buttonValue: '4',
                  ),
                  ButtonWidget(
                      buttonValue: '-',
                      buttonBgColor: operatorColor,
                      textColor: orangeColor)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                children: [
                  ButtonWidget(
                    buttonValue: '3',
                  ),
                  ButtonWidget(
                    buttonValue: '2',
                  ),
                  ButtonWidget(
                    buttonValue: '1',
                  ),
                  ButtonWidget(
                      buttonValue: '+',
                      buttonBgColor: operatorColor,
                      textColor: orangeColor)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                children: [
                  ButtonWidget(
                      buttonValue: '%',
                      buttonBgColor: operatorColor,
                      textColor: orangeColor),
                  ButtonWidget(
                    buttonValue: '0',
                  ),
                  ButtonWidget(
                      buttonValue: '.',
                      buttonBgColor: operatorColor,
                      textColor: orangeColor),
                  ButtonWidget(buttonValue: '=', buttonBgColor: orangeColor)
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget ButtonWidget(
      {buttonValue, buttonBgColor = buttonColor, textColor = Colors.white}) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.all(1.3),
      height: 60,
      width: 40,
      margin: EdgeInsets.only(left: 6, right: 6),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: const Color.fromARGB(255, 69, 68, 68),
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(12)),
              backgroundColor: buttonBgColor),
          onPressed: () {
            resultHandler(buttonValue);
          },
          child: Text(
            buttonValue,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
          )),
    ));
  }
}
