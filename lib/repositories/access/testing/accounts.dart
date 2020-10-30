import 'dart:async';
import 'package:Envely/logic/models/models.dart';
import 'package:Envely/logic/exceptions/exceptions.dart';

import '../abstract/abstract.dart';

class FakeAccountsRepository extends AccountsRepository {
  Map<String, List<Account>> accounts;
  StreamController<List<Account>> streamController;

  Future<void> createAccount(Budget budget, Account account) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    accounts[budget.id].add(account);
    streamController.add([...accounts[budget.id]]);
  }

  Stream<List<Account>> getAccounts(Budget budget) {
    return streamController.stream;
  }

  Future<void> updateAccount(Budget budget, Account account) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    for (var i = 0; i < accounts.length; i++) {
      if (accounts[budget.id][i].id == account.id) {
        accounts[budget.id][i] = account;
        streamController.add([...accounts[budget.id]]);
        return null;
      }
    }
    throw AccountsException(message: "This account doesn't exists");
  }

  Future<void> deleteAccount(Budget budget, Account account) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    for (var i = 0; i < accounts.length; i++) {
      if (accounts[budget.id][i].id == account.id) {
        accounts[budget.id].removeAt(i);
        streamController.add([...accounts[budget.id]]);
        return null;
      }
    }
    throw AccountsException(message: "This account doesn't exists");
  }
}
