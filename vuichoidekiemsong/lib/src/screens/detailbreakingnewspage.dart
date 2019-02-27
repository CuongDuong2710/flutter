import 'package:flutter/material.dart';
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

  DetailBreakingNewsPageState(this.news);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

    );
  }
}