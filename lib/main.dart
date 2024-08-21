import 'package:calculator/calculator_button.dart';
import 'package:calculator/constants.dart';
import 'package:calculator/operand_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'calculator'.toUpperCase(),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = '0';
  String result = '0';
  String expression = '';

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        equation = '0';
        result = '0';
      } else if (buttonText == '=') {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('%', '/100');
        try {
          Parser parser = Parser();
          Expression exp = parser.parse(expression);

          ContextModel contextModel = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, contextModel)}';
        } catch (e) {
          result = 'Error';
        }
      } else {
        if (equation == '0') {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
    String buttonText,
    double buttonHeight,
  ) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      child: TextButton(
        onPressed: () => buttonPressed(buttonText),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(20.0),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgrondColor,
      appBar: AppBar(
        title: Text(
          'Calculator'.toUpperCase(),
          style: const TextStyle(
              wordSpacing: 5,
              color: displayFontColor,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: backgrondColor,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: const TextStyle(fontSize: 38.0, color: displayFontColor),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: const TextStyle(fontSize: 48.0, color: displayFontColor),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            color: backgrondColor,
            child: Column(
              children: [
                Row(
                  children: [
                    CalculatorButton(text: "7", onPressed: buttonPressed),
                    CalculatorButton(text: "8", onPressed: buttonPressed),
                    CalculatorButton(text: "9", onPressed: buttonPressed),
                    OperandButton(text: "÷", onPressed: buttonPressed),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    CalculatorButton(text: "4", onPressed: buttonPressed),
                    CalculatorButton(text: "5", onPressed: buttonPressed),
                    CalculatorButton(text: "6", onPressed: buttonPressed),
                    OperandButton(text: "×", onPressed: buttonPressed),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    CalculatorButton(text: "1", onPressed: buttonPressed),
                    CalculatorButton(text: "2", onPressed: buttonPressed),
                    CalculatorButton(text: "3", onPressed: buttonPressed),
                    OperandButton(text: "-", onPressed: buttonPressed),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    CalculatorButton(text: "0", onPressed: buttonPressed),
                    OperandButton(text: ".", onPressed: buttonPressed),
                    OperandButton(text: "%", onPressed: buttonPressed),
                    OperandButton(text: "+", onPressed: buttonPressed),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    OperandButton(text: "C", onPressed: buttonPressed),
                    OperandButton(text: "=", onPressed: buttonPressed),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
