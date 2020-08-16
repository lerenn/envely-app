import 'dart:async';

import 'package:Envely/exceptions/exceptions.dart';
import 'package:Envely/models/models.dart';

import 'abstract.dart';

class FakeAccountsRepository extends AccountsRepository {
  List<Account> accounts;
  StreamController<List<Account>> streamController;

  Future<void> createAccount(Account account) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    accounts.add(account);
    streamController.add([...accounts]);
  }

  Stream<List<Account>> getAccounts() {
    return streamController.stream;
  }

  Future<void> updateAccount(Account account) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    for (var i = 0; i < accounts.length; i++) {
      if (accounts[i].id == account.id) {
        accounts[i] = account;
        streamController.add([...accounts]);
        return null;
      }
    }
    throw AccountsException(message: "This account doesn't exists");
  }

  Future<void> deleteAccount(Account account) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    for (var i = 0; i < accounts.length; i++) {
      if (accounts[i].id == account.id) {
        accounts.removeAt(i);
        streamController.add([...accounts]);
        return null;
      }
    }
    throw AccountsException(message: "This account doesn't exists");
  }
}
