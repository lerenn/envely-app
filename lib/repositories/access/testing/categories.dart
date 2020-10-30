import 'dart:async';

import 'package:Envely/models/models.dart';
import 'package:Envely/exceptions/exceptions.dart';

import '../abstract/abstract.dart';

class FakeCategoriesRepository extends CategoriesRepository {
  Map<String, List<Category>> categories;
  StreamController<List<Category>> streamController;

  Future<void> createCategory(Budget budget, Category category) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    categories[budget.id].add(category);
    streamController.add([...categories[budget.id]]);
  }

  Stream<List<Category>> getCategories(Budget budget) {
    return streamController.stream;
  }

  Future<void> updateCategory(Budget budget, Category category) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    for (var i = 0; i < categories.length; i++) {
      if (categories[budget.id][i].id == category.id) {
        categories[budget.id][i] = category;
        streamController.add([...categories[budget.id]]);
        return null;
      }
    }
    throw CategoriesException(message: "This category doesn't exists");
  }

  Future<void> deleteCategory(Budget budget, Category category) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    for (var i = 0; i < categories.length; i++) {
      if (categories[budget.id][i].id == category.id) {
        categories[budget.id].removeAt(i);
        streamController.add([...categories[budget.id]]);
        return null;
      }
    }
    throw CategoriesException(message: "This category doesn't exists");
  }
}
