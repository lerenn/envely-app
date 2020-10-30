import 'package:Envely/models/models.dart';
import 'package:Envely/exceptions/exceptions.dart';

import '../abstract/abstract.dart';

class FakeAuthenticationRepository extends AuthenticationRepository {
  User _user;

  @override
  Future<User> getCurrentUser() async {
    return _user;
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay

    if (email.toLowerCase() != 'test@domain.com' || password != 'testpass123') {
      throw AuthenticationException(message: 'Wrong username or password');
    }

    _user = User(id: "uid0", name: 'User', email: email);
    return _user;
  }

  @override
  Future<User> signUp(String name, String email, String password) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    _user = User(id: "uid0", name: name, email: email);
    return _user;
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    _user = null;
    return _user = null;
  }
}
