import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;

  User({@required this.id, @required this.name, @required this.email});

  @override
  String toString() => 'User { name: $name, email: $email}';

  @override
  List<Object> get props => [id, name, email];
}
