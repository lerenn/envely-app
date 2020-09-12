import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:Envely/repositories/repositories.dart';
import 'package:Envely/models/models.dart';

import 'accounts_event.dart';
import 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  final AccountsRepository _accountsRepository;
  StreamSubscription _accountsSubscription;
  Budget selectedBudget;

  AccountsBloc({@required AccountsRepository accountsRepository})
      : assert(accountsRepository != null),
        _accountsRepository = accountsRepository,
        super(AccountsInit());

  @override
  Stream<AccountsState> mapEventToState(AccountsEvent event) async* {
    if (event is AccountsLoad) {
      yield* _mapAccountsLoadToState(event);
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

  Stream<AccountsState> _mapAccountsLoadToState(AccountsLoad event) async* {
    yield AccountsLoading();

    // Cancel old subscriptions
    _accountsSubscription?.cancel();

    // Update budget
    selectedBudget = event.budget;

    // Get new subscription
    try {
      _accountsSubscription =
          _accountsRepository.getAccounts(selectedBudget).listen(
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
    assert(selectedBudget != null);
    yield AccountsLoading();
    try {
      _accountsRepository.updateAccount(selectedBudget, event.account);
      yield AccountUpdatedSuccess();
    } catch (error) {
      yield AccountUpdatedFailure(error: error.toString());
    }
  }

  Stream<AccountsState> _mapAccountCreatedToState(AccountCreated event) async* {
    assert(selectedBudget != null);
    yield AccountsLoading();
    try {
      _accountsRepository.createAccount(selectedBudget, event.account);
      yield AccountCreatedSuccess();
    } catch (error) {
      yield AccountCreatedFailure(error: error.toString());
    }
  }

  Stream<AccountsState> _mapAccountDeletedToState(AccountDeleted event) async* {
    assert(selectedBudget != null);
    yield AccountsLoading();
    try {
      _accountsRepository.deleteAccount(selectedBudget, event.account);
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
