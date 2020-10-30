import 'package:Envely/repositories/entities/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum AccountType {
  Checking,
  Cash,
  CreditCard,
  Asset, // e.g. Investment
  Liability, // e.g. Mortgage
  Unknown
}

extension AccountTypeExtension on AccountType {
  String name() {
    switch (this) {
      case AccountType.Checking:
        return 'Checking';
      case AccountType.Cash:
        return 'Cash';
      case AccountType.CreditCard:
        return 'Credit Card';
      case AccountType.Asset:
        return 'Asset (Ex: investment)';
      case AccountType.Liability:
        return 'Liability (Ex: mortgage)';
      default:
        return this.toString().split('.')[1];
    }
  }

  String mode() {
    switch (this) {
      case AccountType.Checking: /* Fallthrough */
      case AccountType.Cash: /* Fallthrough */
      case AccountType.CreditCard:
        return 'Budget';
      case AccountType.Asset: /* Fallthrough */
      case AccountType.Liability:
        return 'Tracking';
      default:
        return 'Unknown';
    }
  }

  String short() {
    return this.toString().split('.')[1];
  }
}

class Account extends Equatable {
  final String id;
  final String name;
  final AccountType type;

  Account({@required this.id, @required this.name, @required this.type});

  @override
  String toString() => 'Account { id: $id, name: $name, type: $type}';

  AccountEntity toEntity() {
    return AccountEntity(id, name, type.short());
  }

  static Account fromEntity(AccountEntity entity) {
    var type = AccountType.Unknown;
    AccountType.values.forEach((t) {
      if (t.short() == entity.type) type = t;
    });

    return Account(
      id: entity.id,
      name: entity.name,
      type: type,
    );
  }

  @override
  List<Object> get props => [id, name, type];
}
