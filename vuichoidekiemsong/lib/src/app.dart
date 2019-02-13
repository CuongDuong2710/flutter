import 'package:flutter/material.dart';
import 'screens/my_home_page.dart';
import 'screens/xay_dung_thuong_hieu_ca_nhan.dart';
import 'screens/lo_copywriter.dart';

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
