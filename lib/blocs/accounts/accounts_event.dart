import 'package:equatable/equatable.dart';

import 'package:Envely/models/models.dart';

abstract class AccountsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AccountsLoad extends AccountsEvent {}

class AccountsUpdated extends AccountsEvent {
  final List<Account> accounts;

  AccountsUpdated(this.accounts);

  @override
  List<Object> get props => [accounts];

  @override
  String toString() => 'AccountsUpdated { accounts: $accounts }';
}

class AccountCreated extends AccountsEvent {
  final Account account;

  AccountCreated(this.account);

  @override
  List<Object> get props => [account];

  @override
  String toString() => 'AccountCreated { account: $account }';
}

class AccountUpdated extends AccountsEvent {
  final Account account;

  AccountUpdated(this.account);

  @override
  List<Object> get props => [account];

  @override
  String toString() => 'AccountUpdated { account: $account }';
}

class AccountDeleted extends AccountsEvent {
  final Account account;

  AccountDeleted(this.account);

  @override
  List<Object> get props => [account];

  @override
  String toString() => 'AccountDeleted { account: $account }';
}
