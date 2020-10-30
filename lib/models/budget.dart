import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum Currency { EUR, GBP, USD, Custom }

extension CurrencyExtension on Currency {
  String name() {
    switch (this) {
      case Currency.EUR:
        return "Euro(s)";
      case Currency.GBP:
        return "Pound(s) sterling";
      case Currency.USD:
        return "US Dollar(s)";
      default:
        return this.toString().split('.')[1];
    }
  }

  String short() {
    return this.toString().split('.')[1];
  }

  String symbol() {
    switch (this) {
      case Currency.EUR:
        return "€";
      case Currency.GBP:
        return "£";
      case Currency.USD:
        return "\$";
      default:
        return this.toString().split('.')[1];
    }
  }
}

class Budget extends Equatable {
  final String id;
  final String name;
  final Currency currency;

  Budget({@required this.id, @required this.name, @required this.currency});

  @override
  String toString() => 'Budget { id: $id, name: $name, currency: $currency}';

  @override
  List<Object> get props => [id, name, currency];
}
