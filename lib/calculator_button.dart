// lib/calculator_button.dart

import 'package:calculator/constants.dart';
import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final Function(String) onPressed;

  const CalculatorButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onPressed(text),
        child: Container(
          margin: const EdgeInsets.all(8.0),
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[500]!,
                offset: const Offset(4.0, 4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              ),
              const BoxShadow(
                color: Colors.white,
                offset: Offset(-4.0, -4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: operandButtonColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
