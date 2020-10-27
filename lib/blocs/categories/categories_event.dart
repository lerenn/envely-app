import 'package:equatable/equatable.dart';

import 'package:Envely/models/models.dart';

abstract class CategoriesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoriesLoad extends CategoriesEvent {
  final Budget budget;

  CategoriesLoad(this.budget);
}

class CategoriesUpdated extends CategoriesEvent {
  final List<Category> categories;

  CategoriesUpdated(this.categories);

  @override
  List<Object> get props => [categories];

  @override
  String toString() => 'CategoriesUpdated { categories: $categories }';
}

class CategoryCreated extends CategoriesEvent {
  final Budget budget;
  final Category category;

  CategoryCreated(this.budget, this.category);

  @override
  List<Object> get props => [budget, category];

  @override
  String toString() =>
      'CategoryCreated { budget: $budget, category: $category }';
}

class CategoryUpdated extends CategoriesEvent {
  final Budget budget;
  final Category category;

  CategoryUpdated(this.budget, this.category);

  @override
  List<Object> get props => [budget, category];

  @override
  String toString() =>
      'CategoryUpdated { budget: $budget, category: $category }';
}

class CategoryDeleted extends CategoriesEvent {
  final Budget budget;
  final Category category;

  CategoryDeleted(this.budget, this.category);

  @override
  List<Object> get props => [budget, category];

  @override
  String toString() =>
      'CategoryDeleted { budget: $budget, category: $category }';
}
