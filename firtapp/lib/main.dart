import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class RandomEnglishWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomEnglishWordsState();
  }
}

class RandomEnglishWordsState extends State<RandomEnglishWords> {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return new Text(
      wordPair.asUpperCase,
      style: new TextStyle(fontSize: 22.0)
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "This is my first Flutter App",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("This is Header's title"),
        ),
        body: new Center(
          child: new RandomEnglishWords()
          ),
        ),
    );
  }
}
