import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:gesplai/models/user_login.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  UserLogin? _userFromFirebase(auth.User? user) {
    if (user == null) return null;
    return UserLogin(user.uid, user.email);
  }

  Stream<UserLogin?> get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<UserLogin?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userFromFirebase(credential.user);
    } catch (e) {
      print(e.hashCode);
    }
    return null;
  }

  Future<UserLogin?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(credential.user);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
