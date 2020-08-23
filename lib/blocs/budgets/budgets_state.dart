import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:Envely/models/models.dart';

abstract class BudgetsState extends Equatable {
  @override
  List<Object> get props => [];
}

abstract class BudgetsStateFailure extends BudgetsState {
  final String error;

  BudgetsStateFailure(this.error);

  @override
  List<Object> get props => [error];
}

class BudgetsInit extends BudgetsState {}

class BudgetsLoading extends BudgetsState {}

class BudgetsLoadSuccess extends BudgetsState {
  final List<Budget> budgets;

  BudgetsLoadSuccess([this.budgets = const []]);

  @override
  List<Object> get props => [budgets];
}

class BudgetsLoadFailure extends BudgetsStateFailure {
  BudgetsLoadFailure({@required String error}) : super(error);
}

class BudgetCreatedSuccess extends BudgetsState {}

class BudgetCreatedFailure extends BudgetsStateFailure {
  BudgetCreatedFailure({@required String error}) : super(error);
}

class BudgetUpdatedSuccess extends BudgetsState {}

class BudgetUpdatedFailure extends BudgetsStateFailure {
  BudgetUpdatedFailure({@required String error}) : super(error);
}

class BudgetDeletedSuccess extends BudgetsState {}

class BudgetDeletedFailure extends BudgetsStateFailure {
  BudgetDeletedFailure({@required String error}) : super(error);
}
