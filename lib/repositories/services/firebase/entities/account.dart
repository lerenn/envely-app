import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:Envely/models/models.dart';

class AccountEntity extends Equatable {
  final String id;
  final String name;
  final String type;

  AccountEntity(this.id, this.name, this.type);

  @override
  String toString() {
    return 'AccountEntity { id: $id, name: $name, type: $type }';
  }

  static AccountEntity fromSnapshot(DocumentSnapshot snap) {
    return AccountEntity(
      snap.documentID,
      snap.data['name'],
      snap.data['type'],
    );
  }

  static AccountEntity fromModel(Account account) {
    return AccountEntity(account.id, account.name, account.type.short());
  }

  Account toModel() {
    var type = AccountType.Unknown;
    AccountType.values.forEach((t) {
      if (t.short() == this.type) type = t;
    });

    return Account(
      id: this.id,
      name: this.name,
      type: type,
    );
  }

  Map<String, Object> toDocument() {
    return {
      // No ID here
      'name': name,
      'type': type,
    };
  }

  @override
  List<Object> get props => [id, name, type];
}
