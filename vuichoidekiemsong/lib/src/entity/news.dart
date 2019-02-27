import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  final String title;
  final String url;
  final DocumentReference reference;

  News.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['title'] != null),
        assert(map['url'] != null),
        title = map['title'],
        url = map['url'];

  News.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() {
    return "News<$title>";
  }
}