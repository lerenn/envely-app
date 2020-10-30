import 'common.dart';

import 'package:Envely/models/models.dart';

import 'entities/entities.dart';
import '../../repositories.dart';

class FirebaseCategoriesRepository extends CategoriesRepository {
  Future<void> createCategory(Budget budget, Category category) async {
    var collection = FirebaseCollections.Categories.referenceFromBudget(budget);
    await collection.add(CategoryEntity.fromModel(category).toDocument());
  }

  Stream<List<Category>> getCategories(Budget budget) {
    var collection = FirebaseCollections.Categories.referenceFromBudget(budget);
    return collection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => CategoryEntity.fromSnapshot(doc).toModel())
          .toList();
    });
  }

  Future<void> updateCategory(Budget budget, Category category) {
    var collection = FirebaseCollections.Categories.referenceFromBudget(budget);
    return collection
        .document(category.id)
        .updateData(CategoryEntity.fromModel(category).toDocument());
  }

  Future<void> deleteCategory(Budget budget, Category category) async {
    var collection = FirebaseCollections.Categories.referenceFromBudget(budget);
    await collection.document(category.id).delete();
  }
}
