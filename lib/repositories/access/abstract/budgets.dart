import 'package:Envely/logic/models/models.dart';

abstract class BudgetsRepository {
  Future<void> createBudget(Budget budget);
  Stream<List<Budget>> getBudgets();
  Future<void> updateBudget(Budget budget);
  Future<void> deleteBudget(Budget budget);
}
