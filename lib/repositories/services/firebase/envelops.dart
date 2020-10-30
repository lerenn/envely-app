import 'common.dart';

import 'package:Envely/models/models.dart';

import '../../entities/entities.dart';
import '../../repositories.dart';

class FirebaseEnvelopsRepository extends EnvelopsRepository {
  Future<void> createEnvelop(
      Budget budget, Category category, Envelop envelop) async {
    var collection =
        FirebaseCollections.Envelops.referenceFromCategory(budget, category);
    await collection
        .add(EnvelopEntity.fromModel(envelop).toFirestoreDocument());
  }

  Stream<List<Envelop>> getEnvelops(Budget budget, Category category) {
    var collection =
        FirebaseCollections.Envelops.referenceFromCategory(budget, category);
    return collection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) =>
              EnvelopEntity.fromFirestoreSnapshot(doc).toModel(category))
          .toList();
    });
  }

  Future<void> updateEnvelop(
      Budget budget, Category category, Envelop envelop) {
    var collection =
        FirebaseCollections.Envelops.referenceFromCategory(budget, category);
    return collection
        .document(envelop.id)
        .updateData(EnvelopEntity.fromModel(envelop).toFirestoreDocument());
  }

  Future<void> deleteEnvelop(
      Budget budget, Category category, Envelop envelop) async {
    var collection =
        FirebaseCollections.Envelops.referenceFromCategory(budget, category);
    await collection.document(envelop.id).delete();
  }
}
