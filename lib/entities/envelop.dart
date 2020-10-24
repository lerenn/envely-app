import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class EnvelopEntity extends Equatable {
  final String id;
  final String name;
  final String category;

  EnvelopEntity(this.id, this.name, this.category);

  Map<String, Object> toJSON() {
    return {
      'id': id,
      'name': name,
      'category': category,
    };
  }

  @override
  String toString() {
    return 'EnvelopEntity { id: $id, name: $name, category: $category }';
  }

  static EnvelopEntity fromJSON(Map<String, Object> json) {
    return EnvelopEntity(
      json['id'] as String,
      json['name'] as String,
      json['category'] as String,
    );
  }

  static EnvelopEntity fromSnapshot(DocumentSnapshot snap) {
    return EnvelopEntity(
      snap.documentID,
      snap.data['name'],
      snap.data['category'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      // No ID here
      'name': name,
      'category': category,
    };
  }

  @override
  List<Object> get props => [id, name, category];
}
