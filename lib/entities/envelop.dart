import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class EnvelopEntity extends Equatable {
  final String id;
  final String name;

  EnvelopEntity(this.id, this.name);

  Map<String, Object> toJSON() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'EnvelopEntity { id: $id, name: $name }';
  }

  static EnvelopEntity fromJSON(Map<String, Object> json) {
    return EnvelopEntity(json['id'] as String, json['name'] as String);
  }

  static EnvelopEntity fromSnapshot(DocumentSnapshot snap) {
    return EnvelopEntity(
      snap.documentID,
      snap.data['name'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      // No ID here
      'name': name,
    };
  }

  @override
  List<Object> get props => [id, name];
}
