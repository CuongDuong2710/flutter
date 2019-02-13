import 'package:flutter/material.dart';
import 'screens/my_home_page.dart';

class App extends StatelessWidget {
  final appTitle = 'Vui chơi để kiếm sống';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}
