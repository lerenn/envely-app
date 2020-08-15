import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:Envely/entities/entities.dart';
import 'package:Envely/models/models.dart';

import 'abstract.dart';

class FirebaseAccountsService extends AccountsService {
  final collection = Firestore.instance.collection('accounts');

  Future<void> createAccount(Account account) async {
    await collection.add(account.toEntity().toDocument());
  }

  Stream<List<Account>> getAccounts() {
    return collection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Account.fromEntity(AccountEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  Future<void> updateAccount(Account account) {
    return collection
        .document(account.id)
        .updateData(account.toEntity().toDocument());
  }

  Future<void> deleteAccount(Account account) async {
    await collection.document(account.id).delete();
  }
}
