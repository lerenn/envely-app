import 'package:Envely/models/models.dart';

abstract class AccountsService {
  Future<void> createAccount(Account account);
  Stream<List<Account>> getAccounts();
  Future<void> updateAccount(Account account);
  Future<void> deleteAccount(Account account);
}
