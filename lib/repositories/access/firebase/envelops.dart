import 'package:Envely/repositories/entities/entities.dart';
import 'common.dart';

import 'package:Envely/logic/models/models.dart';

import '../abstract/abstract.dart';

class FirebaseEnvelopsRepository extends EnvelopsRepository {
  Future<void> createEnvelop(
      Budget budget, Category category, Envelop envelop) async {
    var collection =
        FirebaseCollections.Envelops.referenceFromCategory(budget, category);
    await collection.add(envelop.toEntity().toDocument());
  }

  Stream<List<Envelop>> getEnvelops(Budget budget, Category category) {
    var collection =
        FirebaseCollections.Envelops.referenceFromCategory(budget, category);
    return collection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) =>
              Envelop.fromEntity(EnvelopEntity.fromSnapshot(doc), category))
          .toList();
    });
  }

  Future<void> updateEnvelop(
      Budget budget, Category category, Envelop envelop) {
    var collection =
        FirebaseCollections.Envelops.referenceFromCategory(budget, category);
    return collection
        .document(envelop.id)
        .updateData(envelop.toEntity().toDocument());
  }

  Future<void> deleteEnvelop(
      Budget budget, Category category, Envelop envelop) async {
    var collection =
        FirebaseCollections.Envelops.referenceFromCategory(budget, category);
    await collection.document(envelop.id).delete();
  }
}
