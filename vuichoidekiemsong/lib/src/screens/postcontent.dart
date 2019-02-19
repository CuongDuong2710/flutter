import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../entity/post.dart';

class PostContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PostContentState();
  }
}

class PostContentState extends State<PostContent> {
  StreamSubscription<DocumentSnapshot> subscription;
  final CollectionReference collectionReference =
      Firestore.instance.collection("post");

  List _categories = [
    "Vui chơi kiếm sống",
    "Xây dựng thương hiệu cá nhân",
    "Lò Copywriter"
  ];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _seletectedFruit;

  @override
  void initState() {
    _dropDownMenuItems = _buildAndGetDropDownMenuItems(_categories);
    _seletectedFruit = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> _buildAndGetDropDownMenuItems(
      List categories) {
    List<DropdownMenuItem<String>> items = new List();
    for (String category in categories) {
      items.add(
          new DropdownMenuItem(value: category, child: new Text(category)));
    }
    return items;
  }

  void _changedDropDownItem(String selectedFruit) {
    setState(() {
      _seletectedFruit = selectedFruit;
    });
  }

  void _add() {
    Map<String, String> data = <String, String>{
      "categoryId": "2",
      "id": "",
      "title": "New Content",
      "content": "This is new content bla bla bla",
      "image": ""
    };
    collectionReference
        .document()
        .setData(data)
        .whenComplete(() => print("add successfully"));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text('Admin'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          titleField(context),
          Container(margin: EdgeInsets.only(top: 20.0)),
          categoryField(context),
          Container(margin: EdgeInsets.only(top: 20.0)),
          contentField(context),
          Container(margin: EdgeInsets.only(top: 20.0)),
          buttonField()
//          imageField(context)
        ],
      ),
    );
  }

  Widget titleField(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Tiêu đề',
        labelText: 'Tiêu đề',
      ),
    );
  }

  Widget categoryField(BuildContext context) {
    return new Row(children: [
      Text('Thư mục'),
      new Padding(
        padding: EdgeInsets.all(10.0),
        child: new DropdownButton(
          value: _seletectedFruit,
          items: _dropDownMenuItems,
          onChanged: _changedDropDownItem,
        ),
      )
    ]);
  }

  Widget contentField(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(hintText: 'Nội dung', labelText: 'Nội dung'),
    );
  }

  Widget imageField(BuildContext context) {}

  Widget buttonField() {
    return RaisedButton(
        textColor: Colors.blue,
        child: Text('Đăng bài viết'),
        onPressed: () => _add());
  }
}
