import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var input = "";
  var output = "";
  var operation = "";
  var hideinput = false;
  var outputSize = 34.0;

  void buttonClick(String text) {
    print(text);
    //if value="AC"
    if (text == "AC") {
      input = "";
      output = "";
    } else if (text == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (text == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalvalue = expression.evaluate(EvaluationType.REAL, cm);
        output = (finalvalue.toString());
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideinput = true;
        outputSize = 52.0;
      }
    } else {
      input = input + text;
      hideinput = false;
      outputSize = 34.0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //     // backgroundColor: Colors.red,

        //     ),
        body: Column(
      children: [
        //input output area
        Expanded(
            child: Container(
                width: double.infinity,
                // color: Colors.amber,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      hideinput ? "" : input,
                      style: TextStyle(fontSize: 48.0),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      output,
                      style: TextStyle(
                          fontSize: outputSize,
                          color: Colors.white.withOpacity(.7)),
                    ),
                    SizedBox(height: 20.0),
                  ],
                ))),
        //button area
        Row(
          children: [
            button(text: "AC", bgcolor: operatorColor, textcolor: orangeColor),
            button(text: "<", bgcolor: operatorColor, textcolor: orangeColor),
            button(text: "+/-", bgcolor: operatorColor),
            button(text: "/", bgcolor: operatorColor)
          ],
        ),
        Row(
          children: [
            button(text: "7"),
            button(text: "8"),
            button(text: "9"),
            button(text: "*", bgcolor: operatorColor)
          ],
        ),
        Row(
          children: [
            button(text: "4"),
            button(text: "5"),
            button(text: "6"),
            button(text: "+", bgcolor: operatorColor)
          ],
        ),
        Row(
          children: [
            button(text: "1"),
            button(text: "2"),
            button(text: "3"),
            button(text: "-", bgcolor: operatorColor)
          ],
        ),
        Row(
          children: [
            button(text: "%"),
            button(text: "0"),
            button(text: "."),
            button(text: "=", bgcolor: orangeColor)
          ],
        ),
      ],
    ));
  }

  Widget button({textcolor = Colors.white, bgcolor = buttonColor, text}) {
    return Expanded(
      child: Container(
          margin: EdgeInsets.all(8),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(8),
                backgroundColor: bgcolor,
              ),
              onPressed: () => buttonClick(text),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 18,
                    color: textcolor,
                    fontWeight: FontWeight.bold),
              ))),
    );
  }
}
