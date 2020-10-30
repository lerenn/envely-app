import 'package:Envely/models/models.dart';

abstract class CategoriesRepository {
  Future<void> createCategory(Budget budget, Category category);
  Stream<List<Category>> getCategories(Budget budget);
  Future<void> updateCategory(Budget budget, Category category);
  Future<void> deleteCategory(Budget budget, Category category);
}
