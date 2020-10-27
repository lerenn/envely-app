import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:Envely/repositories/repositories.dart';
import 'package:Envely/models/models.dart';

import 'categories_event.dart';
import 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepository _categoriesRepository;
  StreamSubscription _categoriesSubscription;
  Budget selectedBudget;

  CategoriesBloc({@required CategoriesRepository categoriesRepository})
      : assert(categoriesRepository != null),
        _categoriesRepository = categoriesRepository,
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

    // Update budget
    selectedBudget = event.budget;

    // Get new subscription
    try {
      _categoriesSubscription =
          _categoriesRepository.getCategories(selectedBudget).listen(
        (categories) {
          add(
            CategoriesUpdated(categories),
          );
        },
      );
    } catch (error) {
      yield CategoriesLoadFailure(error: error.toString());
    }
  }

  Stream<CategoriesState> _mapCategoryUpdatedToState(
      CategoryUpdated event) async* {
    assert(selectedBudget != null);
    yield CategoriesLoading();
    try {
      _categoriesRepository.updateCategory(selectedBudget, event.category);
      yield CategoryUpdatedSuccess();
    } catch (error) {
      yield CategoryUpdatedFailure(error: error.toString());
    }
  }

  Stream<CategoriesState> _mapCategoryCreatedToState(
      CategoryCreated event) async* {
    assert(selectedBudget != null);
    yield CategoriesLoading();
    try {
      _categoriesRepository.createCategory(selectedBudget, event.category);
      yield CategoryCreatedSuccess();
    } catch (error) {
      yield CategoryCreatedFailure(error: error.toString());
    }
  }

  Stream<CategoriesState> _mapCategoryDeletedToState(
      CategoryDeleted event) async* {
    assert(selectedBudget != null);
    yield CategoriesLoading();
    try {
      _categoriesRepository.deleteCategory(selectedBudget, event.category);
      yield CategoryDeletedSuccess();
    } catch (error) {
      yield CategoryDeletedFailure(error: error.toString());
    }
  }

  Stream<CategoriesState> _mapCategoriesUpdatedToState(
      CategoriesUpdated event) async* {
    yield CategoriesLoadSuccess(event.categories);
  }

  @override
  Future<void> close() {
    _categoriesSubscription?.cancel();
    return super.close();
  }
}
