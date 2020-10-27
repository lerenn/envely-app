import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:Envely/repositories/repositories.dart';

import 'envelops_event.dart';
import 'envelops_state.dart';

class EnvelopsBloc extends Bloc<EnvelopsEvent, EnvelopsState> {
  final EnvelopsRepository _envelopsRepository;
  StreamSubscription _envelopsSubscription;

  EnvelopsBloc({@required EnvelopsRepository envelopsRepository})
      : assert(envelopsRepository != null),
        _envelopsRepository = envelopsRepository,
        super(EnvelopsInit());

  @override
  Stream<EnvelopsState> mapEventToState(EnvelopsEvent event) async* {
    if (event is EnvelopsLoad) {
      yield* _mapEnvelopsLoadToState(event);
    } else if (event is EnvelopCreated) {
      yield* _mapEnvelopCreatedToState(event);
    } else if (event is EnvelopUpdated) {
      yield* _mapEnvelopUpdatedToState(event);
    } else if (event is EnvelopDeleted) {
      yield* _mapEnvelopDeletedToState(event);
    } else if (event is EnvelopsUpdated) {
      yield* _mapEnvelopsUpdatedToState(event);
    }
  }

  Stream<EnvelopsState> _mapEnvelopsLoadToState(EnvelopsLoad event) async* {
    yield EnvelopsLoading();

    // Cancel old subscriptions
    _envelopsSubscription?.cancel();

    // Get new subscription
    try {
      _envelopsSubscription =
          _envelopsRepository.getEnvelops(event.budget).listen(
        (envelops) {
          add(
            EnvelopsUpdated(envelops),
          );
        },
      );
    } catch (error) {
      yield EnvelopsLoadFailure(error: error.toString());
    }
  }

  Stream<EnvelopsState> _mapEnvelopUpdatedToState(EnvelopUpdated event) async* {
    assert(event.budget != null);
    yield EnvelopsLoading();
    try {
      _envelopsRepository.updateEnvelop(event.budget, event.envelop);
      yield EnvelopUpdatedSuccess();
    } catch (error) {
      yield EnvelopUpdatedFailure(error: error.toString());
    }
  }

  Stream<EnvelopsState> _mapEnvelopCreatedToState(EnvelopCreated event) async* {
    assert(event.budget != null);
    yield EnvelopsLoading();
    try {
      _envelopsRepository.createEnvelop(event.budget, event.envelop);
      yield EnvelopCreatedSuccess();
    } catch (error) {
      yield EnvelopCreatedFailure(error: error.toString());
    }
  }

  Stream<EnvelopsState> _mapEnvelopDeletedToState(EnvelopDeleted event) async* {
    assert(event.budget != null);
    yield EnvelopsLoading();
    try {
      _envelopsRepository.deleteEnvelop(event.budget, event.envelop);
      yield EnvelopDeletedSuccess();
    } catch (error) {
      yield EnvelopDeletedFailure(error: error.toString());
    }
  }

  Stream<EnvelopsState> _mapEnvelopsUpdatedToState(
      EnvelopsUpdated event) async* {
    yield EnvelopsLoadSuccess(event.envelops);
  }

  @override
  Future<void> close() {
    _envelopsSubscription?.cancel();
    return super.close();
  }
}
