import 'package:meta/meta.dart';

class User {
  final String lastName;
  final String firstName;
  final String email;

  User(
      {@required this.lastName,
      @required this.firstName,
      @required this.email});

  @override
  String toString() =>
      'User { lastName: $lastName, firstName: $firstName, email: $email}';
}
