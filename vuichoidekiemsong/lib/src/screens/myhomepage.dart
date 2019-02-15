import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'xaydungthuonghieucanhan.dart';
import 'locopywriter.dart';
import 'danhsachbaiviet.dart';
import '../entity/category.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final String title = "Vui chơi để kiếm sống";

  Drawer _getNavDrawer(BuildContext context) {
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
      _getNavItem(Icons.home, "Home", "/"),
      _getNavItem(Icons.beenhere, "Lò Copywriter", LoCopyWriter.routeName),
      _getNavItem(Icons.accessibility, "Xây dựng thương hiệu cá nhân",
          XayDungThuongHieuCaNhan.routeName),
      aboutChild
    ];

    ListView listView = new ListView(children: myNavChildren);

    return new Drawer(child: listView);
  }

  ListTile _getNavItem(var icon, String text, String routeName) {
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
      body: _buildBody(context),
      drawer: _getNavDrawer(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('category').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildList(context, snapshot.data.documents);
        });
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final category = Category.fromSnapshot(data);

    return Padding(
      key: ValueKey(category.id),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0)),
        child: ListTile(
          title: Text(category.name),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DanhSachBaiViet(category: category)));
          },
        ),
      ),
    );
  }
}
