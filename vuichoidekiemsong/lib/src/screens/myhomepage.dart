import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'postlistpage.dart';
import '../entity/category.dart';
import '../constant/constant.dart';
import '../services/usermanagement.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final String title = "Vui chơi để kiếm sống";
  bool isSignedIn = UserManagement.isSignedIn();

  Drawer _getNavDrawer(BuildContext context) {

    print('isSignedIn - $isSignedIn');

    var headerChild = new DrawerHeader(child: new Text(title));
    var aboutChild = new AboutListTile(
      child: new Text("About"),
      applicationName: title,
      applicationVersion: "v1.0.0",
      applicationIcon: new Icon(Icons.announcement),
      icon: new Icon(Icons.info),
    );

    var postContentChild = new ListTile(
      leading: Icon(Icons.add),
      title: new Text("Đăng bài viết"),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed('/admin');
      },
    );

    var breakingNewsChild = new ListTile(
      leading: Icon(Icons.aspect_ratio),
      title: new Text("Tin vắn"),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed('/news');
      },
    );

    var logInChild = new ListTile(
      leading: Icon(Icons.desktop_mac),
      title: new Text("Đăng nhập"),
      onTap: () {
        Navigator.of(context).pushReplacementNamed('/login');
      },
    );

    var logOutChild = new ListTile(
      leading: Icon(Icons.directions_walk),
      title: new Text("Đăng xuất"),
      onTap: () {
        FirebaseAuth.instance.signOut().then((value) {
          Navigator.of(context).pushReplacementNamed('/login');
        }).catchError((e) {
          print(e);
        });
      },
    );

    var postNewsChild = new ListTile(
      leading: Icon(Icons.add_comment),
      title: new Text("Đăng tin vắn"),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed('/postnews');
      },
    );

    var myNavChildren = [
      headerChild,
      _getNavItem(Icons.home, "Home", "/"),
      _getNavItem(Icons.beenhere, "Lò Copywriter", Constant.LoCopyWriterRouteName),
      _getNavItem(Icons.ac_unit, "Vui chơi để kiếm sống", Constant.VuiChoiDeKiemSongRouteName),
      _getNavItem(Icons.accessibility, "Xây dựng thương hiệu cá nhân",
          Constant.XayDungThuongHieuCaNhanRouteName),
      breakingNewsChild,
      postNewsChild,
      postContentChild,
      isSignedIn ? logOutChild : logInChild,
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
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Image.network(category.image),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PostListPage(category: category)));
          },
        ),
      ),
    );
  }
}
