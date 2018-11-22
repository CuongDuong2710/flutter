import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Let see some images'),
        ),
        body: Center(
          child: Text('Body'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              print('Hi there!'),
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}