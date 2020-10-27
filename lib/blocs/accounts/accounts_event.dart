import 'package:equatable/equatable.dart';

import 'package:Envely/models/models.dart';

abstract class AccountsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AccountsLoad extends AccountsEvent {
  final Budget budget;

  AccountsLoad(this.budget);
}

class AccountsUpdated extends AccountsEvent {
  final List<Account> accounts;

  AccountsUpdated(this.accounts);

  @override
  List<Object> get props => [accounts];

  @override
  String toString() => 'AccountsUpdated { accounts: $accounts }';
}

class AccountCreated extends AccountsEvent {
  final Budget budget;
  final Account account;

  AccountCreated(this.budget, this.account);

  @override
  List<Object> get props => [budget, account];

  @override
  String toString() => 'AccountCreated { budget: $budget, account: $account }';
}

class AccountUpdated extends AccountsEvent {
  final Budget budget;
  final Account account;

  AccountUpdated(this.budget, this.account);

  @override
  List<Object> get props => [budget, account];

  @override
  String toString() => 'AccountUpdated { budget: $budget, account: $account }';
}

class AccountDeleted extends AccountsEvent {
  final Budget budget;
  final Account account;

  AccountDeleted(this.budget, this.account);

  @override
  List<Object> get props => [budget, account];

  @override
  String toString() => 'AccountDeleted { budget: $budget, account: $account }';
}
