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

  @override
  List<Object> get props => [id, name, category];
}
