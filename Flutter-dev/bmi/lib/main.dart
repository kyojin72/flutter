import 'input_page.dart';
import 'package:flutter/material.dart';
import 'resultpage.dart';

void main() => runApp(const BMICalculator());

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/respage': (context) => ResultPage(),
      },
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        primaryColor: const Color(0xFF0A0E21),
        appBarTheme: const AppBarTheme(color: Color(0xFF0A0E21)),
      ),
      home: const InputPage(),
    );
  }
}
