import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:Envely/logic/models/models.dart';

enum FirebaseCollections {
  Accounts,
  Budgets,
  Categories,
  Envelops,
}

extension FirebaseCollectionsExtension on FirebaseCollections {
  String get name {
    switch (this) {
      case FirebaseCollections.Accounts:
        return 'accounts';
      case FirebaseCollections.Budgets:
        return 'budgets';
      case FirebaseCollections.Categories:
        return 'categories';
      case FirebaseCollections.Envelops:
        return 'envelops';
      default:
        return 'unknown';
    }
  }

  CollectionReference reference() {
    return Firestore.instance.collection(this.name);
  }

  CollectionReference referenceFromBudget(Budget budget) {
    final budgetCollection = FirebaseCollections.Budgets.reference();
    return budgetCollection.document(budget.id).collection(this.name);
  }

  CollectionReference referenceFromCategory(Budget budget, Category category) {
    final budgetCollection = FirebaseCollections.Budgets.reference();
    final categoryCollection = budgetCollection
        .document(budget.id)
        .collection(FirebaseCollections.Categories.name);
    return categoryCollection.document(category.id).collection(this.name);
  }
}
