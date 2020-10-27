import 'package:Envely/entities/entities.dart';
import 'package:Envely/models/models.dart';
import 'package:Envely/repositories/providers/firebase.dart';

import 'abstract.dart';

class FirebaseEnvelopsRepository extends EnvelopsRepository {
  Future<void> createEnvelop(Budget budget, Envelop envelop) async {
    var collection = FirebaseCollections.Envelops.referenceFromBudget(budget);
    await collection.add(envelop.toEntity().toDocument());
  }

  Stream<List<Envelop>> getEnvelops(Budget budget) {
    var collection = FirebaseCollections.Envelops.referenceFromBudget(budget);
    return collection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Envelop.fromEntity(EnvelopEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  Future<void> updateEnvelop(Budget budget, Envelop envelop) {
    var collection = FirebaseCollections.Envelops.referenceFromBudget(budget);
    return collection
        .document(envelop.id)
        .updateData(envelop.toEntity().toDocument());
  }

  Future<void> deleteEnvelop(Budget budget, Envelop envelop) async {
    var collection = FirebaseCollections.Envelops.referenceFromBudget(budget);
    await collection.document(envelop.id).delete();
  }
}
