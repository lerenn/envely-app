import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final int position;

  CategoryEntity(this.id, this.name, this.position);

  Map<String, Object> toJSON() {
    return {
      'id': id,
      'name': name,
      'position': position,
    };
  }

  @override
  String toString() {
    return 'CategoryEntity { id: $id, name: $name, position: $position }';
  }

  static CategoryEntity fromJSON(Map<String, Object> json) {
    return CategoryEntity(
      json['id'] as String,
      json['name'] as String,
      json['position'] as int,
    );
  }

  static CategoryEntity fromSnapshot(DocumentSnapshot snap) {
    return CategoryEntity(
      snap.documentID,
      snap.data['name'],
      snap.data['position'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      // No ID here
      'name': name,
      'position': position,
    };
  }

  @override
  List<Object> get props => [id, name, position];
}
