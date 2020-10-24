import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:Envely/entities/entities.dart';
import 'package:Envely/models/models.dart';

import 'abstract.dart';

class FirebaseEnvelopsRepository extends EnvelopsRepository {
  final budgetCollection = Firestore.instance.collection('budgets');
  final envelopsCollectionName = 'envelops';

  CollectionReference _envelopCollection(Budget budget) {
    return budgetCollection
        .document(budget.id)
        .collection(envelopsCollectionName);
  }

  Future<void> createEnvelop(Budget budget, Envelop envelop) async {
    var collection = _envelopCollection(budget);
    await collection.add(envelop.toEntity().toDocument());
  }

  Stream<List<Envelop>> getEnvelops(Budget budget) {
    var collection = _envelopCollection(budget);
    return collection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Envelop.fromEntity(EnvelopEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  Future<void> updateEnvelop(Budget budget, Envelop envelop) {
    var collection = _envelopCollection(budget);
    return collection
        .document(envelop.id)
        .updateData(envelop.toEntity().toDocument());
  }

  Future<void> deleteEnvelop(Budget budget, Envelop envelop) async {
    var collection = _envelopCollection(budget);
    await collection.document(envelop.id).delete();
  }
}
