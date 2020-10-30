import 'package:Envely/models/models.dart';

import 'common.dart';
import '../../entities/entities.dart';
import '../../repositories.dart';

class FirebaseAccountsRepository extends AccountsRepository {
  Future<void> createAccount(Budget budget, Account account) async {
    var collection = FirebaseCollections.Accounts.referenceFromBudget(budget);
    await collection
        .add(AccountEntity.fromModel(account).toFirestoreDocument());
  }

  Stream<List<Account>> getAccounts(Budget budget) {
    var collection = FirebaseCollections.Accounts.referenceFromBudget(budget);
    return collection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => AccountEntity.fromFirestoreSnapshot(doc).toModel())
          .toList();
    });
  }

  Future<void> updateAccount(Budget budget, Account account) {
    var collection = FirebaseCollections.Accounts.referenceFromBudget(budget);
    return collection
        .document(account.id)
        .updateData(AccountEntity.fromModel(account).toFirestoreDocument());
  }

  Future<void> deleteAccount(Budget budget, Account account) async {
    var collection = FirebaseCollections.Accounts.referenceFromBudget(budget);
    await collection.document(account.id).delete();
  }
}
