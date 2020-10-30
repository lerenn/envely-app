import 'dart:async';

import 'package:Envely/logic/models/models.dart';
import 'package:Envely/logic/exceptions/exceptions.dart';

import '../abstract/abstract.dart';

class FakeEnvelopsRepository extends EnvelopsRepository {
  Map<String, Map<String, List<Envelop>>> envelops;
  StreamController<List<Envelop>> streamController;

  Future<void> createEnvelop(
      Budget budget, Category category, Envelop envelop) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    envelops[budget.id][category.id].add(envelop);
    streamController.add([...envelops[budget.id][category.id]]);
  }

  Stream<List<Envelop>> getEnvelops(Budget budget, Category category) {
    return streamController.stream;
  }

  Future<void> updateEnvelop(
      Budget budget, Category category, Envelop envelop) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    for (var i = 0; i < envelops.length; i++) {
      if (envelops[budget.id][category.id][i].id == envelop.id) {
        envelops[budget.id][category.id][i] = envelop;
        streamController.add([...envelops[budget.id][category.id]]);
        return null;
      }
    }
    throw EnvelopsException(message: "This envelop doesn't exists");
  }

  Future<void> deleteEnvelop(
      Budget budget, Category category, Envelop envelop) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    for (var i = 0; i < envelops.length; i++) {
      if (envelops[budget.id][category.id][i].id == envelop.id) {
        envelops[budget.id][category.id].removeAt(i);
        streamController.add([...envelops[budget.id][category.id]]);
        return null;
      }
    }
    throw EnvelopsException(message: "This envelop doesn't exists");
  }
}
