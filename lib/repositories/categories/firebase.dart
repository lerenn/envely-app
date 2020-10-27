import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:Envely/entities/entities.dart';
import 'package:Envely/models/models.dart';

import 'abstract.dart';

class FirebaseCategoriesRepository extends CategoriesRepository {
  final budgetCollection = Firestore.instance.collection('budgets');
  final categoriesCollectionName = 'categories';

  CollectionReference _categoryCollection(Budget budget) {
    return budgetCollection
        .document(budget.id)
        .collection(categoriesCollectionName);
  }

  Future<void> createCategory(Budget budget, Category category) async {
    var collection = _categoryCollection(budget);
    await collection.add(category.toEntity().toDocument());
  }

  Stream<List<Category>> getCategories(Budget budget) {
    var collection = _categoryCollection(budget);
    return collection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Category.fromEntity(CategoryEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  Future<void> updateCategory(Budget budget, Category category) {
    var collection = _categoryCollection(budget);
    return collection
        .document(category.id)
        .updateData(category.toEntity().toDocument());
  }

  Future<void> deleteCategory(Budget budget, Category category) async {
    var collection = _categoryCollection(budget);
    await collection.document(category.id).delete();
  }
}
