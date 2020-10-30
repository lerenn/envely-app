import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:Envely/models/models.dart';

class BudgetEntity extends Equatable {
  final String id;
  final String name;
  final String currency;

  BudgetEntity(this.id, this.name, this.currency);

  @override
  String toString() {
    return 'BudgetEntity { id: $id, name: $name, currency: $currency }';
  }

  static BudgetEntity fromFirestoreSnapshot(DocumentSnapshot snap) {
    return BudgetEntity(
      snap.documentID,
      snap.data['name'],
      snap.data['currency'],
    );
  }

  static BudgetEntity fromModel(Budget budget) {
    return BudgetEntity(budget.id, budget.name, budget.currency.short());
  }

  Budget toModel() {
    var currency = Currency.Custom;
    Currency.values.forEach((t) {
      if (t.short() == this.currency) currency = t;
    });

    return Budget(
      id: this.id,
      name: this.name,
      currency: currency,
    );
  }

  Map<String, Object> toFirestoreDocument() {
    return {
      // No ID here
      'name': name,
      'currency': currency,
    };
  }

  @override
  List<Object> get props => [id, name, currency];
}
