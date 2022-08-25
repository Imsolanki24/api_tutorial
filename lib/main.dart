import 'package:api_tutorial/example_four.dart';
import 'package:api_tutorial/home_screen.dart';
import 'package:flutter/material.dart';
import 'example.dart';
import 'example_three.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Example_Four(),
    );
  }
}
