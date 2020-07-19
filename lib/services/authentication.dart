import 'package:firebase_auth/firebase_auth.dart';

import 'package:Envely/exceptions/exceptions.dart';
import 'package:Envely/models/models.dart';

abstract class AuthenticationService {
  Future<User> getCurrentUser();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<User> signUp(String name, String email, String password);
}

class FirebaseAuthentication extends AuthenticationService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser _firebaseUser;
  User _cachedUser;

  void _setFromFirebaseUser() {
    _cachedUser = User(
        id: _firebaseUser.uid,
        name: _firebaseUser.displayName,
        email: _firebaseUser.email);
  }

  Future<User> getCurrentUser() async {
    return _cachedUser;
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    _firebaseUser = result.user;

    if (_firebaseUser == null || _firebaseUser.getIdToken() == null)
      throw AuthenticationException(message: result.toString());

    _setFromFirebaseUser();
    return _cachedUser;
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future<User> signUp(String name, String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (_firebaseUser == null || _firebaseUser.getIdToken() == null)
      throw AuthenticationException(message: result.toString());

    _setFromFirebaseUser();
    return _cachedUser;
  }
}

class FakeAuthenticationService extends AuthenticationService {
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
