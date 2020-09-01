import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:Envely/entities/entities.dart';
import 'package:Envely/models/models.dart';

import 'abstract.dart';

class FirebaseAccountsRepository extends AccountsRepository {
  final budgetCollection = Firestore.instance.collection('budgets');
  final accountsCollectionName = 'accounts';

  CollectionReference _accountCollection(Budget budget) {
    return budgetCollection
        .document(budget.id)
        .collection(accountsCollectionName);
  }

  Future<void> createAccount(Budget budget, Account account) async {
    var collection = _accountCollection(budget);
    await collection.add(account.toEntity().toDocument());
  }

  Stream<List<Account>> getAccounts(Budget budget) {
    var collection = _accountCollection(budget);
    return collection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Account.fromEntity(AccountEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  Future<void> updateAccount(Budget budget, Account account) {
    var collection = _accountCollection(budget);
    return collection
        .document(account.id)
        .updateData(account.toEntity().toDocument());
  }

  Future<void> deleteAccount(Budget budget, Account account) async {
    var collection = _accountCollection(budget);
    await collection.document(account.id).delete();
  }
}
