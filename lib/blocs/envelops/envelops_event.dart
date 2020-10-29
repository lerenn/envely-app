import 'package:equatable/equatable.dart';

import 'package:Envely/models/models.dart';

abstract class EnvelopsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EnvelopsLoad extends EnvelopsEvent {
  final Budget budget;
  final Category category;

  EnvelopsLoad(this.budget, this.category);
}

class EnvelopsUpdated extends EnvelopsEvent {
  final Category category;
  final List<Envelop> envelops;

  EnvelopsUpdated(this.category, this.envelops);

  @override
  List<Object> get props => [category, envelops];

  @override
  String toString() =>
      'EnvelopsUpdated { category: $category, envelops: $envelops }';
}

class EnvelopCreated extends EnvelopsEvent {
  final Budget budget;
  final Category category;
  final Envelop envelop;

  EnvelopCreated(this.budget, this.category, this.envelop);

  @override
  List<Object> get props => [budget, category, envelop];

  @override
  String toString() =>
      'EnvelopCreated { budget: $budget, category:$category, envelop: $envelop }';
}

class EnvelopUpdated extends EnvelopsEvent {
  final Budget budget;
  final Category category;
  final Envelop envelop;

  EnvelopUpdated(this.budget, this.category, this.envelop);

  @override
  List<Object> get props => [budget, category, envelop];

  @override
  String toString() =>
      'EnvelopUpdated { budget: $budget, category: $category, envelop: $envelop }';
}

class EnvelopDeleted extends EnvelopsEvent {
  final Budget budget;
  final Category category;
  final Envelop envelop;

  EnvelopDeleted(this.budget, this.category, this.envelop);

  @override
  List<Object> get props => [budget, category, envelop];

  @override
  String toString() =>
      'EnvelopDeleted { budget: $budget, category: $category, envelop: $envelop }';
}
