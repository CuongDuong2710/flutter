import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../entity/news.dart';

class DetailBreakingNewsPage extends StatefulWidget {
  final News news;

  DetailBreakingNewsPage({Key key, @required this.news}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new DetailBreakingNewsPageState(news);
  }
}

class DetailBreakingNewsPageState extends State<DetailBreakingNewsPage> {
  final News news;
  VideoPlayerController _controller;
  VoidCallback listener;

  DetailBreakingNewsPageState(this.news);

  @override
  void initState() {
    super.initState();
    listener = () {
      setState(() {
      });
    };

    _controller = VideoPlayerController.network(news.url)
      ..addListener(listener)
      ..setVolume(1.0)
      ..initialize()
      ..setLooping(true)
      ..play();
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

  Widget _previewVideo(VideoPlayerController controller) {
    if (controller.value.initialized) {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: AspectRatioVideo(controller),
      );
    } else {
      return Text(
        'Loading...',
        textAlign: TextAlign.center,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(news.title),
      ),
      body: new Padding(
        padding: EdgeInsets.all(10.0),
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              _previewVideo(_controller),
              Text(
                news.title,
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.5, fontSize: 20.0),
              )
            ],
          ),
        ),
      ),
    );
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