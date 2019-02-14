import 'package:flutter/material.dart';

class XayDungThuongHieuCaNhan extends StatelessWidget {
  final String title = "Xây dựng thương hiệu cá nhân";
  static const String routeName = "/xaydungthuonghieucanhan";

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