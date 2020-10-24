import 'package:Envely/entities/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Envelop extends Equatable {
  final String id;
  final String name;
  final String category;

  Envelop({@required this.id, @required this.name, @required this.category});

  @override
  String toString() => 'Envelop { id: $id, name: $name, category: $category}';

  EnvelopEntity toEntity() {
    return EnvelopEntity(id, name, category);
  }

  static Envelop fromEntity(EnvelopEntity entity) {
    return Envelop(
      id: entity.id,
      name: entity.name,
      category: entity.category,
    );
  }

  @override
  List<Object> get props => [id, name, category];
}
