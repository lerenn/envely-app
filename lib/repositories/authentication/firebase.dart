import 'package:firebase_auth/firebase_auth.dart';

import 'package:Envely/models/models.dart';
import 'package:Envely/exceptions/exceptions.dart';

import 'abstract.dart';

class FirebaseAuthenticationRepository extends AuthenticationRepository {
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
    _firebaseUser = result.user;

    if (_firebaseUser == null || _firebaseUser.getIdToken() == null)
      throw AuthenticationException(message: result.toString());

    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = name;
    await _firebaseUser.updateProfile(updateInfo);

    _firebaseUser = await _firebaseAuth.currentUser();
    print('USERNAME IS: ${_firebaseUser.displayName}');

    _setFromFirebaseUser();
    return _cachedUser;
  }
}
