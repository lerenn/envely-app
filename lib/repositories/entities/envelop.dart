import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:Envely/models/models.dart';

class EnvelopEntity extends Equatable {
  final String id;
  final String name;

  EnvelopEntity(this.id, this.name);

  @override
  String toString() {
    return 'EnvelopEntity { id: $id, name: $name }';
  }

  static EnvelopEntity fromFirestoreSnapshot(DocumentSnapshot snap) {
    return EnvelopEntity(
      snap.documentID,
      snap.data['name'],
    );
  }

  static EnvelopEntity fromModel(Envelop envelop) {
    return EnvelopEntity(envelop.id, envelop.name);
  }

  Envelop toModel(Category category) {
    return Envelop(id: this.id, name: this.name, category: category);
  }

  Map<String, Object> toFirestoreDocument() {
    return {
      // No ID here
      'name': name,
    };
  }

  @override
  List<Object> get props => [id, name];
}
