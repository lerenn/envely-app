import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:Envely/repositories/repositories.dart';

import 'budgets_event.dart';
import 'budgets_state.dart';

class BudgetsBloc extends Bloc<BudgetsEvent, BudgetsState> {
  final BudgetsRepository _budgetsRepository;
  StreamSubscription _budgetsSubscription;

  BudgetsBloc({@required BudgetsRepository budgetsRepository})
      : assert(budgetsRepository != null),
        _budgetsRepository = budgetsRepository,
        super(BudgetsInit());

  @override
  Stream<BudgetsState> mapEventToState(BudgetsEvent event) async* {
    if (event is BudgetsLoad) {
      yield* _mapBudgetsLoadToState();
    } else if (event is BudgetCreated) {
      yield* _mapBudgetCreatedToState(event);
    } else if (event is BudgetUpdated) {
      yield* _mapBudgetUpdatedToState(event);
    } else if (event is BudgetDeleted) {
      yield* _mapBudgetDeletedToState(event);
    } else if (event is BudgetsUpdated) {
      yield* _mapBudgetsUpdatedToState(event);
    }
  }

  Stream<BudgetsState> _mapBudgetsLoadToState() async* {
    yield BudgetsLoading();
    _budgetsSubscription?.cancel();
    try {
      _budgetsSubscription = _budgetsRepository.getBudgets().listen(
        (budgets) {
          add(
            BudgetsUpdated(budgets),
          );
        },
      );
    } catch (error) {
      yield BudgetsLoadFailure(error: error.toString());
    }
  }

  Stream<BudgetsState> _mapBudgetUpdatedToState(BudgetUpdated event) async* {
    yield BudgetsLoading();
    try {
      _budgetsRepository.updateBudget(event.budget);
      yield BudgetUpdatedSuccess();
    } catch (error) {
      yield BudgetUpdatedFailure(error: error.toString());
    }
  }

  Stream<BudgetsState> _mapBudgetCreatedToState(BudgetCreated event) async* {
    yield BudgetsLoading();
    try {
      _budgetsRepository.createBudget(event.budget);
      yield BudgetCreatedSuccess();
    } catch (error) {
      yield BudgetCreatedFailure(error: error.toString());
    }
  }

  Stream<BudgetsState> _mapBudgetDeletedToState(BudgetDeleted event) async* {
    yield BudgetsLoading();
    try {
      _budgetsRepository.deleteBudget(event.budget);
      yield BudgetDeletedSuccess();
    } catch (error) {
      yield BudgetDeletedFailure(error: error.toString());
    }
  }

  Stream<BudgetsState> _mapBudgetsUpdatedToState(BudgetsUpdated event) async* {
    yield BudgetsLoadSuccess(event.budgets);
  }

  @override
  Future<void> close() {
    _budgetsSubscription?.cancel();
    return super.close();
  }
}
