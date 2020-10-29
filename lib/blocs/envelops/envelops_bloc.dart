import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:Envely/repositories/repositories.dart';
import 'package:Envely/models/models.dart';

import 'package:Envely/blocs/categories/categories.dart';

import 'envelops_event.dart';
import 'envelops_state.dart';

class EnvelopsBloc extends Bloc<EnvelopsEvent, EnvelopsState> {
  final CategoriesBloc _categoriesBloc;
  final EnvelopsRepository _repository;
  Map<Category, StreamSubscription> _envelopsSubscriptions;
  Map<Category, List<Envelop>> _envelopsCache;

  EnvelopsBloc(
      {@required EnvelopsRepository repository,
      @required CategoriesBloc categoriesBloc})
      : assert(repository != null),
        _repository = repository,
        _categoriesBloc = categoriesBloc,
        super(EnvelopsInit()) {
    // Initialize other attributes
    _envelopsSubscriptions = Map<Category, StreamSubscription>();
    _envelopsCache = Map<Category, List<Envelop>>();

    // Link to cateogry BLoC
    _categoriesBloc.listen((CategoriesState state) {
      if (state is CategoriesLoadSuccess) {
        state.categories.forEach((element) {
          this.add(EnvelopsLoad(state.budget, element));
        });
      }
    });
  }

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
    assert(event.budget != null);
    assert(event.category != null);
    yield EnvelopsLoading();

    // Cancel old subscriptions
    if (_envelopsSubscriptions.containsKey(event.category.id))
      _envelopsSubscriptions[event.category.id]?.cancel();

    // Get new subscription
    try {
      _envelopsSubscriptions[event.category] =
          _repository.getEnvelops(event.budget, event.category).listen(
        (envelops) {
          add(
            EnvelopsUpdated(event.budget, event.category, envelops),
          );
        },
      );
    } catch (error) {
      yield EnvelopsLoadFailure(error: error.toString());
    }
  }

  Stream<EnvelopsState> _mapEnvelopUpdatedToState(EnvelopUpdated event) async* {
    assert(event.budget != null);
    assert(event.category != null);
    yield EnvelopsLoading();
    try {
      _repository.updateEnvelop(event.budget, event.category, event.envelop);
      yield EnvelopUpdatedSuccess();
    } catch (error) {
      yield EnvelopUpdatedFailure(error: error.toString());
    }
  }

  Stream<EnvelopsState> _mapEnvelopCreatedToState(EnvelopCreated event) async* {
    assert(event.budget != null);
    assert(event.category != null);
    yield EnvelopsLoading();
    try {
      _repository.createEnvelop(event.budget, event.category, event.envelop);
      yield EnvelopCreatedSuccess();
    } catch (error) {
      yield EnvelopCreatedFailure(error: error.toString());
    }
  }

  Stream<EnvelopsState> _mapEnvelopDeletedToState(EnvelopDeleted event) async* {
    assert(event.budget != null);
    assert(event.category != null);
    yield EnvelopsLoading();
    try {
      _repository.deleteEnvelop(event.budget, event.category, event.envelop);
      yield EnvelopDeletedSuccess();
    } catch (error) {
      yield EnvelopDeletedFailure(error: error.toString());
    }
  }

  Stream<EnvelopsState> _mapEnvelopsUpdatedToState(
      EnvelopsUpdated event) async* {
    // Create a new shallow map to avoid comparing the same map on state
    Map<Category, List<Envelop>> newCache =
        new Map<Category, List<Envelop>>.from(_envelopsCache)
          ..addAll({event.category: event.envelops});

    // Yield new map as state
    yield EnvelopsLoadSuccess(newCache);

    // Assign new map
    _envelopsCache = newCache;
  }

  @override
  Future<void> close() {
    _envelopsSubscriptions.forEach((_, subscription) {
      subscription?.cancel();
    });
    return super.close();
  }
}
