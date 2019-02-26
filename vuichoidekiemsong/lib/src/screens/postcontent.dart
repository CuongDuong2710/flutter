import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../entity/category.dart';

class PostContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PostContentState();
  }
}

class PostContentState extends State<PostContent> {
  final titleTextController = TextEditingController();
  final contentTextController = TextEditingController();

  File _image;

  final CollectionReference collectionReference =
      Firestore.instance.collection("post");

  List _categories = [
    Category("1", "Vui chơi kiếm sống", ""),
    Category("2", "Xây dựng thương hiệu cá nhân", ""),
    Category("3", "Lò Copywriter", "")
  ];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _seletectedCategory;

  @override
  void initState() {
    _dropDownMenuItems = _buildAndGetDropDownMenuItems(_categories);
    _seletectedCategory = _dropDownMenuItems[0].value;
    super.initState();
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  List<DropdownMenuItem<String>> _buildAndGetDropDownMenuItems(
      List categories) {
    List<DropdownMenuItem<String>> items = new List();
    for (Category category in categories) {
      items.add(new DropdownMenuItem(
          value: category.id, child: new Text(category.name)));
    }
    return items;
  }

  void _changedDropDownItem(String selectedCategory) {
    setState(() {
      _seletectedCategory = selectedCategory;
      print("category: " + _seletectedCategory);
    });
  }

  void _add(String categoryId, String title, String content) async {

    // upload image to firestore
    final StorageReference storageReference = FirebaseStorage.instance.ref().child('myimage.jpg');
    final StorageUploadTask task = storageReference.putFile(_image);

    var url = await storageReference.getDownloadURL() as String;
    print('url ${url}');

    Map<String, String> data = <String, String>{
      "categoryId": categoryId,
      "id": "",
      "title": title,
      "content": content,
      "image": url // get image url
    };

    // set data to firebase database
     collectionReference
        .document()
        .setData(data)
        .whenComplete(() => print("add successfully"));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Admin'),
        ),
        body: SingleChildScrollView(
          child: _buildBody(context),
        ));
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
          imageField(context),
          buttonField()
        ],
      ),
    );
  }

  Widget titleField(BuildContext context) {
    return TextField(
      controller: titleTextController,
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
          value: _seletectedCategory,
          items: _dropDownMenuItems,
          onChanged: _changedDropDownItem,
        ),
      )
    ]);
  }

  Widget contentField(BuildContext context) {
    return TextField(
      controller: contentTextController,
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      decoration: InputDecoration(hintText: 'Nội dung', labelText: 'Nội dung'),
    );
  }

  Widget imageField(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _image == null ? Text('No image selected.') : Image.file(_image, height: 300.0, width: 300.0),
          RaisedButton(
            textColor: Colors.blue,
            child: Text('Up hình'),
            onPressed: getImage,
          )
        ],
      ),
    );
  }

  Widget buttonField() {
    return RaisedButton(
        textColor: Colors.blue,
        child: Text('Đăng bài viết'),
        onPressed: () => _add(_seletectedCategory, titleTextController.text,
            contentTextController.text));
  }
}
