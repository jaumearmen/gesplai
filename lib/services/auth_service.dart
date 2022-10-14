import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:gesplai/models/user_login.dart';
import 'package:gesplai/models/user.dart' as UserAux;
import 'package:gesplai/globals.dart' as globals;

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  UserLogin? _userFromFirebase(auth.User? userLogin) {
    if (userLogin == null) {
      return null;
    } else {
      return UserLogin(userLogin.uid, userLogin.email);
    }
  }

  Stream<UserLogin?> get getUser {
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
    String name,
    String username,
    String description,
    String idEsplai,
    String day,
    String startHour,
    String endHour,
    String localization,
    bool isEsplai,
  ) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final refUser = FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid);

      final newUser = UserAux.User(
        userId: credential.user!.uid,
        name: name,
        username: username,
        email: email,
        day: day,
        description: description,
        endHour: endHour,
        idEsplai: idEsplai,
        startHour: startHour,
        localization: localization,
        lastMessageTime: DateTime.now(),
        isEsplai: isEsplai,
      );

      globals.uid = credential.user!.uid;
      await refUser.set(newUser.toJson());
      return _userFromFirebase(credential.user);
    } on auth.FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
    return null;
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
