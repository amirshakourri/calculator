import 'package:calculator_project/constans.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  var userInput = '';
  var result = '';

  buttonPressed(String text) {
    setState(() {
      userInput = userInput + text;
    });
  }

  Widget getRow(
    String text1,
    String text2,
    String text3,
    String text4,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {
            if (text1 == "AC") {
              setState(() {
                userInput = '';
                result = '';
              });
            } else {
              buttonPressed(text1);
            }
          },
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 3, color: Colors.transparent),
            ),
            backgroundColor: getBackground(text1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              '$text1',
              style: TextStyle(fontSize: 23, color: getOperatorColor(text1)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            if (text2 == 'CE') {
              //TOMAROW TASK
              //why doesent crash when length less than 0
              // try to fix it

              // you working good today but i wanna more try harding from you
              setState(() {
                if (userInput.length > 0) {
                  userInput = userInput.substring(0, userInput.length - 1);
                }
              });
            } else {
              buttonPressed(text2);
            }
          },
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 3, color: Colors.transparent),
            ),
            backgroundColor: getBackground(text2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              '$text2',
              style: TextStyle(fontSize: 23, color: getOperatorColor(text2)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            buttonPressed(text3);
          },
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 3, color: Colors.transparent),
            ),
            backgroundColor: getBackground(text3),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              '$text3',
              style: TextStyle(fontSize: 23, color: getOperatorColor(text3)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            if (text4 == '=') {
              Parser parser = Parser();
              Expression expression = parser.parse(userInput);
              ContextModel contextModel = ContextModel();
              double eval =
                  expression.evaluate(EvaluationType.REAL, contextModel);
              setState(() {
                result = eval.toString();
              });
            } else {
              buttonPressed(text4);
            }
          },
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 3, color: Colors.transparent),
            ),
            backgroundColor: getBackground(text4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              '$text4',
              style: TextStyle(fontSize: 23, color: getOperatorColor(text4)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 200,
                  color: backgroundGreyDark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          userInput,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: textGreen,
                            fontSize: 28,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          result,
                          style: TextStyle(
                            color: textGrey,
                            fontSize: 62,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  height: 200,
                  color: backgroundGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      getRow("AC", "CE", "%", "/"),
                      getRow("7", "8", "9", "*"),
                      getRow("4", "5", "6", "-"),
                      getRow("3", "2", "1", "+"),
                      getRow("00", "0", ".", "="),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isOperator(String text) {
    List operator = ["AC", "CE", "%", "/", "*", "-", "+", "="];
    for (var item in operator) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  Color getBackground(String text) {
    if (isOperator(text)) {
      return backgroundGreyDark;
    } else {
      return backgroundGrey;
    }
  }

  Color getOperatorColor(String text) {
    if (isOperator(text)) {
      return textGreen;
    } else {
      return textGrey;
    }
  }
}
