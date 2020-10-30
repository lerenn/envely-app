import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AccountEntity extends Equatable {
  final String id;
  final String name;
  final String type;

  AccountEntity(this.id, this.name, this.type);

  Map<String, Object> toJSON() {
    return {
      'id': id,
      'name': name,
      'type': type,
    };
  }

  @override
  String toString() {
    return 'AccountEntity { id: $id, name: $name, type: $type }';
  }

  static AccountEntity fromJSON(Map<String, Object> json) {
    return AccountEntity(
      json['id'] as String,
      json['name'] as String,
      json['type'] as String,
    );
  }

  static AccountEntity fromSnapshot(DocumentSnapshot snap) {
    return AccountEntity(
      snap.documentID,
      snap.data['name'],
      snap.data['type'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      // No ID here
      'name': name,
      'type': type,
    };
  }

  @override
  List<Object> get props => [id, name, type];
}
