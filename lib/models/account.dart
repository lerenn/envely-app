import 'package:Envely/entities/entities.dart';
import 'package:meta/meta.dart';

enum AccountType {
  Checking,
  Cash,
  CreditCard,
  Asset, // e.g. Investment
  Liability, // e.g. Mortgage
  Unknown
}

class Account {
  final String id;
  final String name;
  final AccountType type;

  Account({@required this.id, @required this.name, @required this.type});

  @override
  String toString() => 'Account { id: $id, name: $name, type: $type}';

  AccountEntity toEntity() {
    return AccountEntity(id, name, type.toString());
  }

  static Account fromEntity(AccountEntity entity) {
    var type = AccountType.Unknown;
    AccountType.values.forEach((t) {
      if (t.toString() == entity.type) type = t;
    });

    return Account(
      id: entity.id,
      name: entity.name,
      type: type,
    );
  }
}
