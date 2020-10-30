import 'common.dart';

import 'package:Envely/models/models.dart';

import '../../entities/entities.dart';
import '../../repositories.dart';

class FirebaseCategoriesRepository extends CategoriesRepository {
  Future<void> createCategory(Budget budget, Category category) async {
    var collection = FirebaseCollections.Categories.referenceFromBudget(budget);
    await collection
        .add(CategoryEntity.fromModel(category).toFirestoreDocument());
  }

  Stream<List<Category>> getCategories(Budget budget) {
    var collection = FirebaseCollections.Categories.referenceFromBudget(budget);
    return collection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => CategoryEntity.fromFirestoreSnapshot(doc).toModel())
          .toList();
    });
  }

  Future<void> updateCategory(Budget budget, Category category) {
    var collection = FirebaseCollections.Categories.referenceFromBudget(budget);
    return collection
        .document(category.id)
        .updateData(CategoryEntity.fromModel(category).toFirestoreDocument());
  }

  Future<void> deleteCategory(Budget budget, Category category) async {
    var collection = FirebaseCollections.Categories.referenceFromBudget(budget);
    await collection.document(category.id).delete();
  }
}
