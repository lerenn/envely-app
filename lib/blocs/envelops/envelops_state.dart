import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:Envely/models/models.dart';

abstract class EnvelopsState extends Equatable {
  @override
  List<Object> get props => [];
}

abstract class EnvelopsStateFailure extends EnvelopsState {
  final String error;

  EnvelopsStateFailure(this.error);

  @override
  List<Object> get props => [error];
}

class EnvelopsInit extends EnvelopsState {}

class EnvelopsLoading extends EnvelopsState {}

class EnvelopsLoadSuccess extends EnvelopsState {
  final Map<Category, List<Envelop>> envelops;

  EnvelopsLoadSuccess(this.envelops);

  @override
  List<Object> get props => [envelops];
}

class EnvelopsLoadFailure extends EnvelopsStateFailure {
  EnvelopsLoadFailure({@required String error}) : super(error);
}

class EnvelopCreatedSuccess extends EnvelopsState {}

class EnvelopCreatedFailure extends EnvelopsStateFailure {
  EnvelopCreatedFailure({@required String error}) : super(error);
}

class EnvelopUpdatedSuccess extends EnvelopsState {}

class EnvelopUpdatedFailure extends EnvelopsStateFailure {
  EnvelopUpdatedFailure({@required String error}) : super(error);
}

class EnvelopDeletedSuccess extends EnvelopsState {}

class EnvelopDeletedFailure extends EnvelopsStateFailure {
  EnvelopDeletedFailure({@required String error}) : super(error);
}
