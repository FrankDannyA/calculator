import 'package:calculator/my_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = "";
  var userAnswer = "";

  final myTextStyle = TextStyle(fontSize: 30, color: Colors.deepPurple[900]);
  final List<String> buttons = [
    "C",
    "Del",
    "%",
    "/",
    "9",
    "8",
    "7",
    "X",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "ANS",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userQuestion,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userAnswer,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (BuildContext context, int index) {
                //Clear Button
                if (index == 0) {
                  return MyButton(
                    textButton: buttons[index],
                    color: Colors.green,
                    onTap: () {
                      setState(() {
                        userQuestion = "";
                      });
                    },
                  );

                  //Delete button
                } else if (index == 1) {
                  return MyButton(
                    textButton: buttons[index],
                    color: Colors.red,
                    onTap: () {
                      setState(() {
                        userQuestion =
                            userQuestion.substring(0, userQuestion.length - 1);
                      });
                    },
                  );

                  //Equals button
                } else if (index == buttons.length - 1) {
                  return MyButton(
                    textButton: buttons[index],
                    color: Colors.deepPurple,
                    onTap: () {
                      setState(() {
                        equalParser();
                      });
                    },
                  );

                  //Rest Buttons
                } else {
                  return MyButton(
                    textButton: buttons[index],
                    color: isOperation(buttons[index])
                        ? Colors.deepPurple
                        : Colors.deepPurple[50],
                    textStyle: isOperation(buttons[index])
                        ? const TextStyle(color: Colors.white, fontSize: 30)
                        : myTextStyle,
                    onTap: () {
                      setState(() {
                        userQuestion += buttons[index];
                      });
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  bool isOperation(String x) {
    if (x == "/" || x == "%" || x == "X" || x == "+" || x == "-" || x == "=") {
      return true;
    }
    return false;
  }

  void equalParser() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll("X", "*");

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
