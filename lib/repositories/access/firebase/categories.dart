import 'package:Envely/repositories/entities/entities.dart';
import 'common.dart';

import 'package:Envely/models/models.dart';

import '../abstract/abstract.dart';

class FirebaseCategoriesRepository extends CategoriesRepository {
  Future<void> createCategory(Budget budget, Category category) async {
    var collection = FirebaseCollections.Categories.referenceFromBudget(budget);
    await collection.add(category.toEntity().toDocument());
  }

  Stream<List<Category>> getCategories(Budget budget) {
    var collection = FirebaseCollections.Categories.referenceFromBudget(budget);
    return collection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Category.fromEntity(CategoryEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  Future<void> updateCategory(Budget budget, Category category) {
    var collection = FirebaseCollections.Categories.referenceFromBudget(budget);
    return collection
        .document(category.id)
        .updateData(category.toEntity().toDocument());
  }

  Future<void> deleteCategory(Budget budget, Category category) async {
    var collection = FirebaseCollections.Categories.referenceFromBudget(budget);
    await collection.document(category.id).delete();
  }
}
