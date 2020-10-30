import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:Envely/models/models.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final int position;

  CategoryEntity(this.id, this.name, this.position);

  @override
  String toString() {
    return 'CategoryEntity { id: $id, name: $name, position: $position }';
  }

  static CategoryEntity fromSnapshot(DocumentSnapshot snap) {
    return CategoryEntity(
      snap.documentID,
      snap.data['name'],
      snap.data['position'],
    );
  }

  static CategoryEntity fromModel(Category category) {
    return CategoryEntity(category.id, category.name, category.position);
  }

  Category toModel() {
    return Category(
      id: this.id,
      name: this.name,
      position: this.position,
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
