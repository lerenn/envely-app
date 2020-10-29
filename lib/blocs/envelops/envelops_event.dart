import 'package:equatable/equatable.dart';

import 'package:Envely/models/models.dart';

abstract class EnvelopsEvent extends Equatable {
  final Budget budget;

  EnvelopsEvent(this.budget);

  @override
  List<Object> get props => [];
}

class EnvelopsLoad extends EnvelopsEvent {
  final Category category;

  EnvelopsLoad(budget, this.category) : super(budget);

  @override
  List<Object> get props => [budget, category];

  @override
  String toString() =>
      'EnvelopsUpdated { budget: $budget, categories: $category}';
}

class EnvelopsUpdated extends EnvelopsEvent {
  final Category category;
  final List<Envelop> envelops;

  EnvelopsUpdated(budget, this.category, this.envelops) : super(budget);

  @override
  List<Object> get props => [budget, envelops];

  @override
  String toString() =>
      'EnvelopsUpdated { budget: $budget, envelops: $envelops }';
}

class EnvelopCreated extends EnvelopsEvent {
  final Category category;
  final Envelop envelop;

  EnvelopCreated(budget, this.category, this.envelop) : super(budget);

  @override
  List<Object> get props => [budget, category, envelop];

  @override
  String toString() =>
      'EnvelopCreated { budget: $budget, category: $category, envelop: $envelop }';
}

class EnvelopUpdated extends EnvelopsEvent {
  final Category category;
  final Envelop envelop;

  EnvelopUpdated(budget, this.category, this.envelop) : super(budget);

  @override
  List<Object> get props => [budget, category, envelop];

  @override
  String toString() =>
      'EnvelopUpdated { budget: $budget, category: $category, envelop: $envelop }';
}

class EnvelopDeleted extends EnvelopsEvent {
  final Category category;
  final Envelop envelop;

  EnvelopDeleted(budget, this.category, this.envelop) : super(budget);

  @override
  List<Object> get props => [budget, category, envelop];

  @override
  String toString() =>
      'EnvelopDeleted { budget: $budget, category: $category, envelop: $envelop }';
}
