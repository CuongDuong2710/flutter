import 'package:flutter/material.dart';
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
            child: new Column(
          children: <Widget>[
            getImageFromNetwork(post.image),
            Text(
              post.content,
              textAlign: TextAlign.center,
              style: TextStyle(height: 1.5, fontSize: 20.0),
            ),
          ],
        )),
      ),
    );
  }

  Image getImageFromNetwork(String link) {
    Image image;
    if (link != null && link.isNotEmpty)
      image = new Image.network(link);
    else
      image = new Image(image: new AssetImage('assets/person.png'));
    return image;
  }
}
