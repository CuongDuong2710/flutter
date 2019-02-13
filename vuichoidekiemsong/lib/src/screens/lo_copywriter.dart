import 'package:flutter/material.dart';

class LoCopyWriter extends StatelessWidget {
  final String title = "Lò CopyWriter";
  static const String routeName = "/locopywriter";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: new Container(
        child: new Center(
          child: new Text(title),
        ),
      ),
    );
  }
}