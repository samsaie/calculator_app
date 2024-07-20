import 'package:calculator_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  var inputUser = '';
  var result = '';

  void buttonPressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  Widget getRow(String text1, String text2, String text3, String text4) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      TextButton(
        style: TextButton.styleFrom(
          shape: const CircleBorder(
            side: BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
          ),
          backgroundColor: getBackgroundColor(text1),
        ),
        onPressed: () {
          if (text1 == 'c') {
            setState(() {
              inputUser = '';
              result = '';
            });
          } else {
            buttonPressed(text1);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text1,
            style: TextStyle(fontSize: 26, color: getTextColor(text1)),
          ),
        ),
      ),
      TextButton(
        style: TextButton.styleFrom(
          shape: const CircleBorder(
            side: BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
          ),
          backgroundColor: getBackgroundColor(text2),
        ),
        onPressed: () {
          if (text2 == '+/-') {
          } else {
            buttonPressed(text2);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text2,
            style: TextStyle(fontSize: 26, color: getTextColor(text2)),
          ),
        ),
      ),
      TextButton(
          style: TextButton.styleFrom(
            shape: const CircleBorder(
              side: BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
            backgroundColor: getBackgroundColor(text3),
          ),
          onPressed: () {
            if (text3 == '=') {
              Parser parser = Parser();
              Expression expression = parser.parse(inputUser);
              ContextModel contextModel = ContextModel();
              double eval =
                  expression.evaluate(EvaluationType.REAL, contextModel);

              setState(() {
                result = eval.toString();
              });
            } else {
              buttonPressed(text3);
            }
          },
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text3,
                style: TextStyle(fontSize: 26, color: getTextColor(text3)),
              ))),
      TextButton(
          style: TextButton.styleFrom(
            shape: const CircleBorder(
                side: BorderSide(
              width: 0,
              color: Colors.transparent,
            )),
            backgroundColor: getBackgroundColor(text4),
          ),
          onPressed: () {
            if (text4 == 'DEL') {
              setState(() {
                if (inputUser.length > 0) {
                  inputUser = inputUser.substring(0, inputUser.length - 1);
                }
              });
            } else {
              buttonPressed(text4);
            }
          },
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text4,
                style: TextStyle(fontSize: 26, color: getTextColor(text4)),
              )))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: SafeArea(
                child: Column(children: [
          Expanded(
              flex: 3,
              child: Container(
                  color: backgroundGreyDark,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(inputUser,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: textGreen,
                                ))),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(result,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: textGreen,
                                )))
                      ]))),
          Expanded(
              flex: 7,
              child: Container(
                  color: backgroundGrey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        getRow('c', '+/-', '%', 'DEL'),
                        getRow('7', '8', '9', '/'),
                        getRow('4', '5', '6', '*'),
                        getRow('1', '2', '3', '-'),
                        getRow('0', '.', '=', '+')
                      ])))
        ]))));
  }

  bool isOprator1(String text) {
    var list = ['c', '+/-', '%', 'DEL'];
    for (var item in list) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  bool isOprator2(String text) {
    var list = ['/', '*', '-', '+'];
    for (var item in list) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  bool isOprator3(String text) {
    if (text == '=') {
      return true;
    }
    return false;
  }

  Color getBackgroundColor(String text) {
    if (isOprator1(text)) {
      return backgroundGreyDark;
    } else if (isOprator2(text)) {
      return backgroundGreen;
    } else if (isOprator3(text)) {
      return Colors.white;
    }
    return backgroundGrey;
  }

  Color getTextColor(String text) {
    if (isOprator1(text)) {
      return textGreen;
    } else if (isOprator2(text)) {
      return textGreyDark;
    } else if (isOprator3(text)) {
      return Colors.black;
    }
    return textGrey;
  }
}
