import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DanhSachBaiViet extends StatefulWidget {
  final String categoryId;

  DanhSachBaiViet({Key key, @required this.categoryId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new DanhSachBaiVietState(categoryId);
  }
}

class DanhSachBaiVietState extends State<DanhSachBaiViet> {
  final String title = "Danh sách bài viết";
  final String categoryId;

  DanhSachBaiVietState(this.categoryId);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: _buildBody(context, categoryId),
    );
  }

  Widget _buildBody(BuildContext context, String categoryId) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('post').where("categoryId", isEqualTo: categoryId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return LinearProgressIndicator();
          return _buildList(context, snapshot.data.documents);
        }
    );
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
          onTap: () => print("post $post"),
        ),
      ),
    );
  }


}

class Post {
  final String id;
  final String categoryId;
  final String title;
  final String content;
  final DocumentReference reference;

  Post.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['id'] != null),
        assert(map['categoryId'] != null),
        assert(map['title'] != null),
        assert(map['content'] != null),
        id = map['id'],
        categoryId = map['categoryId'],
        title = map['title'],
        content = map['content'];

  Post.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() {
    return "Post<$title>";
  }
}
