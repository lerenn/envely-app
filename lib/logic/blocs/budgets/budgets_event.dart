import 'package:equatable/equatable.dart';

import 'package:Envely/logic/models/models.dart';

abstract class BudgetsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BudgetsLoad extends BudgetsEvent {}

class BudgetsUpdated extends BudgetsEvent {
  final List<Budget> budgets;

  BudgetsUpdated(this.budgets);

  @override
  List<Object> get props => [budgets];

  @override
  String toString() => 'BudgetsUpdated { budgets: $budgets }';
}

class BudgetCreated extends BudgetsEvent {
  final Budget budget;

  BudgetCreated(this.budget);

  @override
  List<Object> get props => [budget];

  @override
  String toString() => 'BudgetCreated { budget: $budget }';
}

class BudgetUpdated extends BudgetsEvent {
  final Budget budget;

  BudgetUpdated(this.budget);

  @override
  List<Object> get props => [budget];

  @override
  String toString() => 'BudgetUpdated { budget: $budget }';
}

class BudgetDeleted extends BudgetsEvent {
  final Budget budget;

  BudgetDeleted(this.budget);

  @override
  List<Object> get props => [budget];

  @override
  String toString() => 'BudgetDeleted { budget: $budget }';
}
