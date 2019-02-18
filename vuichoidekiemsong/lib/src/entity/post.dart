import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String categoryId;
  final String title;
  final String content;
  final String image;
  final DocumentReference reference;

  Post.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['id'] != null),
        assert(map['categoryId'] != null),
        assert(map['title'] != null),
        assert(map['content'] != null),
        assert(map['image'] != null),
        id = map['id'],
        categoryId = map['categoryId'],
        title = map['title'],
        content = map['content'],
        image = map['image'];

  Post.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() {
    return "Post<$title>";
  }
}