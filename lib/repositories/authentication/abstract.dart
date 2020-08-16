import 'package:Envely/models/models.dart';

abstract class AuthenticationRepository {
  Future<User> getCurrentUser();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<User> signUp(String name, String email, String password);
}
