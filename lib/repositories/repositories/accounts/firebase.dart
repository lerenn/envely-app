import 'package:Envely/entities/entities.dart';
import 'package:Envely/models/models.dart';
import 'package:Envely/repositories/providers/firebase.dart';

import 'abstract.dart';

class FirebaseAccountsRepository extends AccountsRepository {
  Future<void> createAccount(Budget budget, Account account) async {
    var collection = FirebaseCollections.Accounts.referenceFromBudget(budget);
    await collection.add(account.toEntity().toDocument());
  }

  Stream<List<Account>> getAccounts(Budget budget) {
    var collection = FirebaseCollections.Accounts.referenceFromBudget(budget);
    return collection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Account.fromEntity(AccountEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  Future<void> updateAccount(Budget budget, Account account) {
    var collection = FirebaseCollections.Accounts.referenceFromBudget(budget);
    return collection
        .document(account.id)
        .updateData(account.toEntity().toDocument());
  }

  Future<void> deleteAccount(Budget budget, Account account) async {
    var collection = FirebaseCollections.Accounts.referenceFromBudget(budget);
    await collection.document(account.id).delete();
  }
}
