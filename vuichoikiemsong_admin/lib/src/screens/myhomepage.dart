import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
        textColor: Colors.blue, child: Text('Đăng bài viết'), onPressed: () {});
  }
}
