import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../entity/category.dart';
import '../entity/post.dart';
import 'detailpostpage.dart';

class PostListPage extends StatefulWidget {
  final Category category;

  PostListPage({Key key, @required this.category}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new PostListPageState(category);
  }
}

class PostListPageState extends State<PostListPage> {
  final String title = "Danh sách bài viết";
  final Category category;

  PostListPageState(this.category);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(category.name),
      ),
      body: _buildBody(context, category.id),
    );
  }

  Widget _buildBody(BuildContext context, String categoryId) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('post')
            .where("categoryId", isEqualTo: categoryId)
            .snapshots(),
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
    final post = Post.fromSnapshot(data);

    return Padding(
      key: ValueKey(post.id),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
            title: Text(post.title),
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Image.network(post.image),
            ),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailPostPage(post: post)))),
      ),
    );
  }
}
