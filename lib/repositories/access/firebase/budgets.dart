import 'package:Envely/repositories/entities/entities.dart';
import 'common.dart';

import 'package:Envely/models/models.dart';

import '../abstract/abstract.dart';

class FirebaseBudgetsRepository extends BudgetsRepository {
  final collection = FirebaseCollections.Budgets.reference();

  Future<void> createBudget(Budget budget) async {
    await collection.add(budget.toEntity().toDocument());
  }

  Stream<List<Budget>> getBudgets() {
    return collection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Budget.fromEntity(BudgetEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  Future<void> updateBudget(Budget budget) {
    return collection
        .document(budget.id)
        .updateData(budget.toEntity().toDocument());
  }

  Future<void> deleteBudget(Budget budget) async {
    await collection.document(budget.id).delete();
  }
}
