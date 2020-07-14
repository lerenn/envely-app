import 'package:Envely/exceptions/exceptions.dart';

import 'package:Envely/models/models.dart';

abstract class AuthenticationService {
  Future<User> getCurrentUser();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<User> signUp(
      String lastName, String firstName, String email, String password);
}

class FakeAuthenticationService extends AuthenticationService {
  @override
  Future<User> getCurrentUser() async {
    return null; // return null for now
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay

    if (email.toLowerCase() != 'test@domain.com' || password != 'testpass123') {
      throw AuthenticationException(message: 'Wrong username or password');
    }
    return User(lastName: 'User', firstName: 'Test', email: email);
  }

  @override
  Future<User> signUp(
      String lastName, String firstName, String email, String password) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    return User(lastName: lastName, firstName: firstName, email: email);
  }

  @override
  Future<void> signOut() {
    return null;
  }
}
