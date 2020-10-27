import 'package:equatable/equatable.dart';

import 'package:Envely/models/models.dart';

abstract class EnvelopsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EnvelopsLoad extends EnvelopsEvent {
  final Budget budget;

  EnvelopsLoad(this.budget);
}

class EnvelopsUpdated extends EnvelopsEvent {
  final List<Envelop> envelops;

  EnvelopsUpdated(this.envelops);

  @override
  List<Object> get props => [envelops];

  @override
  String toString() => 'EnvelopsUpdated { envelops: $envelops }';
}

class EnvelopCreated extends EnvelopsEvent {
  final Budget budget;
  final Envelop envelop;

  EnvelopCreated(this.budget, this.envelop);

  @override
  List<Object> get props => [budget, envelop];

  @override
  String toString() => 'EnvelopCreated { budget: $budget, envelop: $envelop }';
}

class EnvelopUpdated extends EnvelopsEvent {
  final Budget budget;
  final Envelop envelop;

  EnvelopUpdated(this.budget, this.envelop);

  @override
  List<Object> get props => [budget, envelop];

  @override
  String toString() => 'EnvelopUpdated { budget: $budget, envelop: $envelop }';
}

class EnvelopDeleted extends EnvelopsEvent {
  final Budget budget;
  final Envelop envelop;

  EnvelopDeleted(this.budget, this.envelop);

  @override
  List<Object> get props => [budget, envelop];

  @override
  String toString() => 'EnvelopDeleted { budget: $budget, envelop: $envelop }';
}
