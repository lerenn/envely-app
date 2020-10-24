import 'dart:async';

import 'package:Envely/exceptions/exceptions.dart';
import 'package:Envely/models/models.dart';

import 'abstract.dart';

class FakeEnvelopsRepository extends EnvelopsRepository {
  Map<String, List<Envelop>> accounts;
  StreamController<List<Envelop>> streamController;

  Future<void> createEnvelop(Budget budget, Envelop account) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    accounts[budget.id].add(account);
    streamController.add([...accounts[budget.id]]);
  }

  Stream<List<Envelop>> getEnvelops(Budget budget) {
    return streamController.stream;
  }

  Future<void> updateEnvelop(Budget budget, Envelop account) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    for (var i = 0; i < accounts.length; i++) {
      if (accounts[budget.id][i].id == account.id) {
        accounts[budget.id][i] = account;
        streamController.add([...accounts[budget.id]]);
        return null;
      }
    }
    throw EnvelopsException(message: "This account doesn't exists");
  }

  Future<void> deleteEnvelop(Budget budget, Envelop account) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    for (var i = 0; i < accounts.length; i++) {
      if (accounts[budget.id][i].id == account.id) {
        accounts[budget.id].removeAt(i);
        streamController.add([...accounts[budget.id]]);
        return null;
      }
    }
    throw EnvelopsException(message: "This account doesn't exists");
  }
}
