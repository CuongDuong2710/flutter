import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String id;
  final String name;
  final String image;
  final DocumentReference reference;

  Category.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['id'] != null),
        assert(map['name'] != null),
        assert(map['image'] != null),
        id = map['id'],
        name = map['name'],
        image = map['image'];

  Category.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Category<$id: $name - $image>";
}