import 'package:flutter/material.dart';
import '../src/screens/myhomepage.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin',
      home: MyHomePage(),
    );
  }
}