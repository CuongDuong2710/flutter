import 'package:flutter/material.dart';
import '../models/imageModel.dart';

class ImageList extends StatelessWidget {
  final  List<ImageModel> images;

  ImageList(this.images);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, int index) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1.0
            )
          ),
          padding: EdgeInsets.all(20.0),
          margin: EdgeInsets.all(20.0),
          child: Image.network(images[index].url),
        );
      }
    );
  }

}