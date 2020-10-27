import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:Envely/models/models.dart';

abstract class CategoriesState extends Equatable {
  @override
  List<Object> get props => [];
}

abstract class CategoriesStateFailure extends CategoriesState {
  final String error;

  CategoriesStateFailure(this.error);

  @override
  List<Object> get props => [error];
}

class CategoriesInit extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoadSuccess extends CategoriesState {
  final List<Category> categories;

  CategoriesLoadSuccess([this.categories = const []]);

  @override
  List<Object> get props => [categories];
}

class CategoriesLoadFailure extends CategoriesStateFailure {
  CategoriesLoadFailure({@required String error}) : super(error);
}

class CategoryCreatedSuccess extends CategoriesState {}

class CategoryCreatedFailure extends CategoriesStateFailure {
  CategoryCreatedFailure({@required String error}) : super(error);
}

class CategoryUpdatedSuccess extends CategoriesState {}

class CategoryUpdatedFailure extends CategoriesStateFailure {
  CategoryUpdatedFailure({@required String error}) : super(error);
}

class CategoryDeletedSuccess extends CategoriesState {}

class CategoryDeletedFailure extends CategoriesStateFailure {
  CategoryDeletedFailure({@required String error}) : super(error);
}
