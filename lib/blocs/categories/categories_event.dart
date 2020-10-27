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
  final Category category;

  CategoryCreated(this.category);

  @override
  List<Object> get props => [category];

  @override
  String toString() => 'CategoryCreated { category: $category }';
}

class CategoryUpdated extends CategoriesEvent {
  final Category category;

  CategoryUpdated(this.category);

  @override
  List<Object> get props => [category];

  @override
  String toString() => 'CategoryUpdated { category: $category }';
}

class CategoryDeleted extends CategoriesEvent {
  final Category category;

  CategoryDeleted(this.category);

  @override
  List<Object> get props => [category];

  @override
  String toString() => 'CategoryDeleted { category: $category }';
}
