import 'package:Envely/models/models.dart';

abstract class AccountsRepository {
  Future<void> createAccount(Budget budget, Account account);
  Stream<List<Account>> getAccounts(Budget budget);
  Future<void> updateAccount(Budget budget, Account account);
  Future<void> deleteAccount(Budget budget, Account account);
}
