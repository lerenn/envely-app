import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:Envely/models/models.dart';

abstract class AccountsState extends Equatable {
  @override
  List<Object> get props => [];
}

class AccountsInit extends AccountsState {}

class AccountsLoading extends AccountsState {}

class AccountsLoadSuccess extends AccountsState {
  final List<Account> accounts;

  AccountsLoadSuccess([this.accounts = const []]);

  @override
  List<Object> get props => [accounts];

  @override
  String toString() => 'AccountsLoadSuccess { accounts: $accounts }';
}

class AccountsLoadFailure extends AccountsState {
  final String error;

  AccountsLoadFailure({@required this.error});

  @override
  List<Object> get props => [error];
}

class AccountCreatedSuccess extends AccountsState {}

class AccountCreatedFailure extends AccountsState {
  final String error;

  AccountCreatedFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
