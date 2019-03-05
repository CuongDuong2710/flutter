import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class PostBreakingNews extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PostBreakingNewsState();
  }
}

class PostBreakingNewsState extends State<PostBreakingNews> {
  VideoPlayerController _controller;
  VoidCallback listener;
  final titleTextController = TextEditingController();

  File _video;
  String _fileName;

  final CollectionReference collectionReference =
      Firestore.instance.collection("news");

  void _onVideoBtnPressed(ImageSource source) {
    setState(() {
      if (_controller != null) {
        _controller.setVolume(0.0);
        _controller.removeListener(listener);
      }
      ImagePicker.pickVideo(source: source).then((File file) {
        if (file != null && mounted) {
          _video = file;
          _fileName = basename(_video.path);

          print('_image.path: $_video.path');
          print('_fileName: $_fileName');

          setState(() {
            _controller = VideoPlayerController.file(file)
              ..addListener(listener)
              ..setVolume(1.0)
              ..initialize()
              ..setLooping(true)
              ..play();
          });
        }
      });
    });
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller.setVolume(0.0);
      _controller.removeListener(listener);
    }
    super.deactivate();
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    listener = () {
      setState(() {});
    };
  }

  Widget _previewVideo(VideoPlayerController controller) {
    if (controller == null) {
      return Text(
        'You have not yet picked a video',
        textAlign: TextAlign.center,
      );
    } else if (controller.value.initialized) {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: AspectRatioVideo(controller),
      );
    } else {
      return Text(
        'Error Loading Video',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget titleField(BuildContext context) {
    return TextField(
      controller: titleTextController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(hintText: 'Tiêu đề', labelText: 'Tiêu đề'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Đăng video"),
      ),
      body: new Padding(
        padding: EdgeInsets.all(10.0),
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              titleField(context),
              _previewVideo(_controller),
              RaisedButton(
                  child: Text('Chọn video'),
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () {
                    _onVideoBtnPressed(ImageSource.gallery);
                  }),
              RaisedButton(
                  child: Text('Up video'),
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () {
                    _addVideo(titleTextController.text);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void _addVideo(String title) async {
    final StorageReference storageReference =
        FirebaseStorage.instance.ref().child(_fileName);
    final StorageUploadTask task = storageReference.putFile(_video);

    var downUrl = await (await task.onComplete).ref.getDownloadURL();
    var url = downUrl.toString();
    print('url>>> ${url}');

    var data = {"title": title, "url": url};

    collectionReference
        .document()
        .setData(data)
        .whenComplete(() => print("add video successfully"));
  }
}

class AspectRatioVideo extends StatefulWidget {
  final VideoPlayerController controller;

  AspectRatioVideo(this.controller);

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController get controller => widget.controller;
  bool initialized = false;

  VoidCallback listener;

  @override
  void initState() {
    super.initState();
    listener = () {
      if (!mounted) {
        return;
      }
      if (initialized != controller.value.initialized) {
        initialized = controller.value.initialized;
        setState(() {});
      }
    };
    controller.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller.value?.aspectRatio,
          child: VideoPlayer(controller),
        ),
      );
    } else {
      return Container();
    }
  }
}