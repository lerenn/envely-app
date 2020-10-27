import 'dart:async';

import 'package:Envely/exceptions/exceptions.dart';
import 'package:Envely/models/models.dart';

import 'abstract.dart';

class FakeEnvelopsRepository extends EnvelopsRepository {
  Map<String, List<Envelop>> envelops;
  StreamController<List<Envelop>> streamController;

  Future<void> createEnvelop(Budget budget, Envelop envelop) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    envelops[budget.id].add(envelop);
    streamController.add([...envelops[budget.id]]);
  }

  Stream<List<Envelop>> getEnvelops(Budget budget) {
    return streamController.stream;
  }

  Future<void> updateEnvelop(Budget budget, Envelop envelop) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    for (var i = 0; i < envelops.length; i++) {
      if (envelops[budget.id][i].id == envelop.id) {
        envelops[budget.id][i] = envelop;
        streamController.add([...envelops[budget.id]]);
        return null;
      }
    }
    throw EnvelopsException(message: "This envelop doesn't exists");
  }

  Future<void> deleteEnvelop(Budget budget, Envelop envelop) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    for (var i = 0; i < envelops.length; i++) {
      if (envelops[budget.id][i].id == envelop.id) {
        envelops[budget.id].removeAt(i);
        streamController.add([...envelops[budget.id]]);
        return null;
      }
    }
    throw EnvelopsException(message: "This envelop doesn't exists");
  }
}
