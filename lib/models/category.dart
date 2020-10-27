import 'package:Envely/entities/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final int position;

  Category({@required this.id, @required this.name, @required this.position});

  @override
  String toString() => 'Category { id: $id, name: $name, position: $position}';

  CategoryEntity toEntity() {
    return CategoryEntity(id, name, position);
  }

  static Category fromEntity(CategoryEntity entity) {
    return Category(
      id: entity.id,
      name: entity.name,
      position: entity.position,
    );
  }

  @override
  List<Object> get props => [id, name, position];
}
