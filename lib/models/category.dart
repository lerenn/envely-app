import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final int position;

  Category({@required this.id, @required this.name, @required this.position});

  @override
  String toString() => 'Category { id: $id, name: $name, position: $position}';

  @override
  List<Object> get props => [id, name, position];
}
