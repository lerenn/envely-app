import 'dart:async';

import 'package:Envely/exceptions/exceptions.dart';
import 'package:Envely/models/models.dart';

import 'abstract.dart';

class FakeBudgetsRepository extends BudgetsRepository {
  List<Budget> budgets;
  StreamController<List<Budget>> streamController;

  Future<void> createBudget(Budget budget) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    budgets.add(budget);
    streamController.add([...budgets]);
  }

  Stream<List<Budget>> getBudgets() {
    return streamController.stream;
  }

  Future<void> updateBudget(Budget budget) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    for (var i = 0; i < budgets.length; i++) {
      if (budgets[i].id == budget.id) {
        budgets[i] = budget;
        streamController.add([...budgets]);
        return null;
      }
    }
    throw BudgetsException(message: "This budget doesn't exists");
  }

  Future<void> deleteBudget(Budget budget) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    for (var i = 0; i < budgets.length; i++) {
      if (budgets[i].id == budget.id) {
        budgets.removeAt(i);
        streamController.add([...budgets]);
        return null;
      }
    }
    throw BudgetsException(message: "This budget doesn't exists");
  }
}
