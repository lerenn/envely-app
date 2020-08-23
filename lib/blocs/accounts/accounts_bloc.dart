import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:Envely/repositories/repositories.dart';

import 'accounts_event.dart';
import 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  final AccountsRepository _accountsRepository;
  StreamSubscription _accountsSubscription;

  AccountsBloc({@required AccountsRepository accountsRepository})
      : assert(accountsRepository != null),
        _accountsRepository = accountsRepository,
        super(AccountsInit());

  @override
  Stream<AccountsState> mapEventToState(AccountsEvent event) async* {
    if (event is AccountsLoad) {
      yield* _mapAccountsLoadToState();
    } else if (event is AccountCreated) {
      yield* _mapAccountCreatedToState(event);
    } else if (event is AccountUpdated) {
      yield* _mapAccountUpdatedToState(event);
    } else if (event is AccountDeleted) {
      yield* _mapAccountDeletedToState(event);
    } else if (event is AccountsUpdated) {
      yield* _mapAccountsUpdatedToState(event);
    }
  }

  Stream<AccountsState> _mapAccountsLoadToState() async* {
    yield AccountsLoading();
    _accountsSubscription?.cancel();
    try {
      _accountsSubscription = _accountsRepository.getAccounts().listen(
        (accounts) {
          add(
            AccountsUpdated(accounts),
          );
        },
      );
    } catch (error) {
      yield AccountsLoadFailure(error: error.toString());
    }
  }

  Stream<AccountsState> _mapAccountUpdatedToState(AccountUpdated event) async* {
    yield AccountsLoading();
    try {
      _accountsRepository.updateAccount(event.account);
      yield AccountUpdatedSuccess();
    } catch (error) {
      yield AccountUpdatedFailure(error: error.toString());
    }
  }

  Stream<AccountsState> _mapAccountCreatedToState(AccountCreated event) async* {
    yield AccountsLoading();
    try {
      _accountsRepository.createAccount(event.account);
      yield AccountCreatedSuccess();
    } catch (error) {
      yield AccountCreatedFailure(error: error.toString());
    }
  }

  Stream<AccountsState> _mapAccountDeletedToState(AccountDeleted event) async* {
    yield AccountsLoading();
    try {
      _accountsRepository.deleteAccount(event.account);
      yield AccountDeletedSuccess();
    } catch (error) {
      yield AccountDeletedFailure(error: error.toString());
    }
  }

  Stream<AccountsState> _mapAccountsUpdatedToState(
      AccountsUpdated event) async* {
    yield AccountsLoadSuccess(event.accounts);
  }

  @override
  Future<void> close() {
    _accountsSubscription?.cancel();
    return super.close();
  }
}
