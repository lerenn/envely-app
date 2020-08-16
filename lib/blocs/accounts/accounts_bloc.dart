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
        super(AccountsLoading());

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
    _accountsSubscription?.cancel();
    _accountsSubscription = _accountsRepository.getAccounts().listen(
      (accounts) {
        add(
          AccountsUpdated(accounts),
        );
      },
    );
  }

  Stream<AccountsState> _mapAccountUpdatedToState(AccountUpdated event) async* {
    _accountsRepository.updateAccount(event.account);
  }

  Stream<AccountsState> _mapAccountCreatedToState(AccountCreated event) async* {
    _accountsRepository.createAccount(event.account);
  }

  Stream<AccountsState> _mapAccountDeletedToState(AccountDeleted event) async* {
    _accountsRepository.deleteAccount(event.account);
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
