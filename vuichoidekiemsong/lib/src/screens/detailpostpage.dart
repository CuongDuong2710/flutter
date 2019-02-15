import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../entity/post.dart';

class DetailPostPage extends StatefulWidget {
  final Post post;

  DetailPostPage({Key key, @required this.post}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new DetailPostPageState(post);
  }
}

class DetailPostPageState extends State<DetailPostPage> {
  final Post post;

  DetailPostPageState(this.post);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: new Padding(
        padding: EdgeInsets.all(10.0),
        child: new SingleChildScrollView(
          child: Text(
            post.content,
            textAlign: TextAlign.center,
            style: TextStyle(height: 1.5, fontSize: 15.0),
          ),
        ),
      ),
    );
  }
}
