import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../entity/news.dart';

class BreakingNewsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new BreakingNewsState();
  }
}

class BreakingNewsState extends State<BreakingNewsList> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Tin vắn'),
      ),
      body: SingleChildScrollView(
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('news').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildList(context, snapshot.data.documents);
        });
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final news = News.fromSnapshot(data);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        child: ListTile(
          title: Text(news.title),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailBreakingNewsPage(news: news))),
        ),
      ),
    );
  }
}
