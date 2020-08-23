import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class BudgetEntity extends Equatable {
  final String id;
  final String name;
  final String currency;

  BudgetEntity(this.id, this.name, this.currency);

  Map<String, Object> toJSON() {
    return {
      'id': id,
      'name': name,
      'currency': currency,
    };
  }

  @override
  String toString() {
    return 'BudgetEntity { id: $id, name: $name, currency: $currency }';
  }

  static BudgetEntity fromJSON(Map<String, Object> json) {
    return BudgetEntity(
      json['id'] as String,
      json['name'] as String,
      json['currency'] as String,
    );
  }

  static BudgetEntity fromSnapshot(DocumentSnapshot snap) {
    return BudgetEntity(
      snap.documentID,
      snap.data['name'],
      snap.data['currency'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      // No ID here
      'name': name,
      'currency': currency,
    };
  }

  @override
  List<Object> get props => [id, name, currency];
}
