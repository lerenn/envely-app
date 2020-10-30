import 'package:Envely/models/models.dart';

abstract class AccountsRepository {
  Future<void> createAccount(Budget budget, Account account);
  Stream<List<Account>> getAccounts(Budget budget);
  Future<void> updateAccount(Budget budget, Account account);
  Future<void> deleteAccount(Budget budget, Account account);
}

abstract class AuthenticationRepository {
  Future<User> getCurrentUser();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<User> signUp(String name, String email, String password);
}

abstract class BudgetsRepository {
  Future<void> createBudget(Budget budget);
  Stream<List<Budget>> getBudgets();
  Future<void> updateBudget(Budget budget);
  Future<void> deleteBudget(Budget budget);
}

abstract class CategoriesRepository {
  Future<void> createCategory(Budget budget, Category category);
  Stream<List<Category>> getCategories(Budget budget);
  Future<void> updateCategory(Budget budget, Category category);
  Future<void> deleteCategory(Budget budget, Category category);
}

abstract class EnvelopsRepository {
  Future<void> createEnvelop(Budget budget, Category category, Envelop envelop);
  Stream<List<Envelop>> getEnvelops(Budget budget, Category category);
  Future<void> updateEnvelop(Budget budget, Category category, Envelop envelop);
  Future<void> deleteEnvelop(Budget budget, Category category, Envelop envelop);
}
