import 'package:flutter/material.dart';
import 'xay_dung_thuong_hieu_ca_nhan.dart';
import 'lo_copywriter.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final String title = "Vui chơi để kiếm sống";

  Drawer getNavDrawer(BuildContext context) {
    var headerChild = new DrawerHeader(child: new Text(title));
    var aboutChild = new AboutListTile(
      child: new Text("About"),
      applicationName: title,
      applicationVersion: "v1.0.0",
      applicationIcon: new Icon(Icons.announcement),
      icon: new Icon(Icons.info),
    );

    var myNavChildren = [
      headerChild,
      getNavItem(Icons.accessibility, "Xây dựng thương hiệu cá nhân",
          XayDungThuongHieuCaNhan.routeName),
      getNavItem(Icons.home, "Home", "/"),
      getNavItem(Icons.beenhere, "Copywriter", LoCopyWriter.routeName),
      aboutChild
    ];

    ListView listView = new ListView(children: myNavChildren);

    return new Drawer(child: listView);
  }

  ListTile getNavItem(var icon, String text, String routeName) {
    return new ListTile(
      leading: new Icon(icon),
      title: new Text(text),
      onTap: () {
        setState(() {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed(routeName);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: new Container(
        child: new Center(
          child: new Text("Home Screen"),
        ),
      ),
      drawer: getNavDrawer(context),
    );
  }
}
