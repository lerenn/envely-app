import 'package:equatable/equatable.dart';

import 'package:Envely/models/models.dart';

abstract class CategoriesEvent extends Equatable {
  final Budget budget;

  CategoriesEvent(this.budget);

  @override
  List<Object> get props => [];
}

class CategoriesLoad extends CategoriesEvent {
  CategoriesLoad(budget) : super(budget);
}

class CategoriesUpdated extends CategoriesEvent {
  final List<Category> categories;

  CategoriesUpdated(budget, this.categories) : super(budget);

  @override
  List<Object> get props => [budget, categories];

  @override
  String toString() =>
      'CategoriesUpdated { budget: $budget, categories: $categories }';
}

class CategoryCreated extends CategoriesEvent {
  final Category category;

  CategoryCreated(budget, this.category) : super(budget);

  @override
  List<Object> get props => [budget, category];

  @override
  String toString() =>
      'CategoryCreated { budget: $budget, category: $category }';
}

class CategoryUpdated extends CategoriesEvent {
  final Category category;

  CategoryUpdated(budget, this.category) : super(budget);

  @override
  List<Object> get props => [budget, category];

  @override
  String toString() =>
      'CategoryUpdated { budget: $budget, category: $category }';
}

class CategoryDeleted extends CategoriesEvent {
  final Category category;

  CategoryDeleted(budget, this.category) : super(budget);

  @override
  List<Object> get props => [budget, category];

  @override
  String toString() =>
      'CategoryDeleted { budget: $budget, category: $category }';
}
