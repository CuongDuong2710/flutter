import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'models/imageModel.dart';
import 'dart:convert'; // contain 'json' to decode
import 'widgets/image_list.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State {
  int counter = 0;
  List<ImageModel> images = [];

  void fetchImage() async {
    counter++;
    var response = await get('https://jsonplaceholder.typicode.com/photos/$counter');
    var imageModel = ImageModel.fromJson(json.decode(response.body));
    setState(() {
      images.add(imageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Let see some images'),
        ),
        body: ImageList(images),
        floatingActionButton: FloatingActionButton(
          onPressed: fetchImage, // get reference of 'fetchImage' anytime button get pressed
          /*onPressed: () {
            fetchImage();
          },*/
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}