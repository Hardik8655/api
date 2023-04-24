import 'package:apicall/screen/fifth_screen.dart';
import 'package:apicall/screen/fourth_screen.dart';
import 'package:apicall/screen/home_screen.dart';
import 'package:apicall/screen/second_screen.dart';
import 'package:apicall/screen/thired_Screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FifthScreen(),
    );
  }
}
