import 'package:flutter/material.dart';
import 'screens/myhomepage.dart';
import 'screens/xaydungthuonghieucanhan.dart';
import 'screens/locopywriter.dart';

class App extends StatelessWidget {
  final appTitle = 'Vui chơi để kiếm sống';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(),
      routes: <String, WidgetBuilder> {
        // define the routes
        XayDungThuongHieuCaNhan.routeName: (BuildContext context) => new XayDungThuongHieuCaNhan(),
        LoCopyWriter.routeName: (BuildContext context) => new LoCopyWriter()
      },
    );
  }
}
