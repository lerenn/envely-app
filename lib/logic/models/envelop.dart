import 'package:Envely/repositories/entities/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'category.dart';

class Envelop extends Equatable {
  final String id;
  final String name;
  final Category category;

  Envelop({@required this.id, @required this.name, @required this.category});

  @override
  String toString() => 'Envelop { id: $id, name: $name, category: $category}';

  EnvelopEntity toEntity() {
    return EnvelopEntity(id, name);
  }

  static Envelop fromEntity(EnvelopEntity entity, Category category) {
    return Envelop(id: entity.id, name: entity.name, category: category);
  }

  @override
  List<Object> get props => [id, name, category];
}
