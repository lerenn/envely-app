import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:Envely/models/models.dart';

abstract class AccountsState extends Equatable {
  @override
  List<Object> get props => [];
}

abstract class AccountsStateFailure extends AccountsState {
  final String error;

  AccountsStateFailure(this.error);

  @override
  List<Object> get props => [error];
}

class AccountsInit extends AccountsState {}

class AccountsLoading extends AccountsState {}

class AccountsLoadSuccess extends AccountsState {
  final List<Account> accounts;

  AccountsLoadSuccess([this.accounts = const []]);

  @override
  List<Object> get props => [accounts];
}

class AccountsLoadFailure extends AccountsStateFailure {
  AccountsLoadFailure({@required String error}) : super(error);
}

class AccountCreatedSuccess extends AccountsState {}

class AccountCreatedFailure extends AccountsStateFailure {
  AccountCreatedFailure({@required String error}) : super(error);
}

class AccountUpdatedSuccess extends AccountsState {}

class AccountUpdatedFailure extends AccountsStateFailure {
  AccountUpdatedFailure({@required String error}) : super(error);
}

class AccountDeletedSuccess extends AccountsState {}

class AccountDeletedFailure extends AccountsStateFailure {
  AccountDeletedFailure({@required String error}) : super(error);
}
