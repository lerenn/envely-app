import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:Envely/repositories/repositories.dart';

import 'categories_event.dart';
import 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepository _repository;
  StreamSubscription _categoriesSubscription;

  CategoriesBloc({@required CategoriesRepository repository})
      : assert(repository != null),
        _repository = repository,
        super(CategoriesInit());

  @override
  Stream<CategoriesState> mapEventToState(CategoriesEvent event) async* {
    if (event is CategoriesLoad) {
      yield* _mapCategoriesLoadToState(event);
    } else if (event is CategoryCreated) {
      yield* _mapCategoryCreatedToState(event);
    } else if (event is CategoryUpdated) {
      yield* _mapCategoryUpdatedToState(event);
    } else if (event is CategoryDeleted) {
      yield* _mapCategoryDeletedToState(event);
    } else if (event is CategoriesUpdated) {
      yield* _mapCategoriesUpdatedToState(event);
    }
  }

  Stream<CategoriesState> _mapCategoriesLoadToState(
      CategoriesLoad event) async* {
    yield CategoriesLoading();

    // Cancel old subscriptions
    _categoriesSubscription?.cancel();

    // Get new subscription
    try {
      _categoriesSubscription = _repository.getCategories(event.budget).listen(
        (categories) {
          add(
            CategoriesUpdated(event.budget, categories),
          );
        },
      );
    } catch (error) {
      yield CategoriesLoadFailure(error: error.toString());
    }
  }

  Stream<CategoriesState> _mapCategoryUpdatedToState(
      CategoryUpdated event) async* {
    assert(event.budget != null);
    yield CategoriesLoading();
    try {
      _repository.updateCategory(event.budget, event.category);
      yield CategoryUpdatedSuccess();
    } catch (error) {
      yield CategoryUpdatedFailure(error: error.toString());
    }
  }

  Stream<CategoriesState> _mapCategoryCreatedToState(
      CategoryCreated event) async* {
    assert(event.budget != null);
    yield CategoriesLoading();
    try {
      _repository.createCategory(event.budget, event.category);
      yield CategoryCreatedSuccess();
    } catch (error) {
      yield CategoryCreatedFailure(error: error.toString());
    }
  }

  Stream<CategoriesState> _mapCategoryDeletedToState(
      CategoryDeleted event) async* {
    assert(event.budget != null);
    yield CategoriesLoading();
    try {
      _repository.deleteCategory(event.budget, event.category);
      yield CategoryDeletedSuccess();
    } catch (error) {
      yield CategoryDeletedFailure(error: error.toString());
    }
  }

  Stream<CategoriesState> _mapCategoriesUpdatedToState(
      CategoriesUpdated event) async* {
    yield CategoriesLoadSuccess(event.budget, event.categories);
  }

  @override
  Future<void> close() {
    _categoriesSubscription?.cancel();
    return super.close();
  }
}
