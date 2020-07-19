import 'package:meta/meta.dart';

class User {
  final String id;
  final String name;
  final String email;

  User({@required this.id, @required this.name, @required this.email});

  @override
  String toString() => 'User { name: $name, email: $email}';
}
