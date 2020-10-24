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
  final Envelop envelop;

  EnvelopCreated(this.envelop);

  @override
  List<Object> get props => [envelop];

  @override
  String toString() => 'EnvelopCreated { envelop: $envelop }';
}

class EnvelopUpdated extends EnvelopsEvent {
  final Envelop envelop;

  EnvelopUpdated(this.envelop);

  @override
  List<Object> get props => [envelop];

  @override
  String toString() => 'EnvelopUpdated { envelop: $envelop }';
}

class EnvelopDeleted extends EnvelopsEvent {
  final Envelop envelop;

  EnvelopDeleted(this.envelop);

  @override
  List<Object> get props => [envelop];

  @override
  String toString() => 'EnvelopDeleted { envelop: $envelop }';
}
