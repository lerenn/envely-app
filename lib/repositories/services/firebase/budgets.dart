import 'common.dart';

import 'package:Envely/models/models.dart';

import 'entities/entities.dart';
import '../../repositories.dart';

class FirebaseBudgetsRepository extends BudgetsRepository {
  final collection = FirebaseCollections.Budgets.reference();

  Future<void> createBudget(Budget budget) async {
    await collection.add(BudgetEntity.fromModel(budget).toDocument());
  }

  Stream<List<Budget>> getBudgets() {
    return collection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => BudgetEntity.fromSnapshot(doc).toModel())
          .toList();
    });
  }

  Future<void> updateBudget(Budget budget) {
    return collection
        .document(budget.id)
        .updateData(BudgetEntity.fromModel(budget).toDocument());
  }

  Future<void> deleteBudget(Budget budget) async {
    await collection.document(budget.id).delete();
  }
}
