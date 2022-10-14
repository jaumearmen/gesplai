import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart' as UserAux;

class UserService {
  static Future<UserAux.User?> getUser() async {
    final doc = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    final snapshot = await doc.get();

    if (snapshot.exists) {
      return UserAux.User.fromJson(snapshot.data()!);
    }
    return null;
  }

  static Future<UserAux.User> getUserByEmail(String email) async {
    final doc = FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email);
    final snapshot = await doc.get();
    var user =
        snapshot.docs.map((doc) => UserAux.User.fromJson(doc.data())).toList();
    return user[0];
  }

  static Future<UserAux.User> getUserByUsername(String username) async {
    final doc = FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username);
    final snapshot = await doc.get();
    var user =
        snapshot.docs.map((doc) => UserAux.User.fromJson(doc.data())).toList();
    return user[0];
  }

  static Future<List<UserAux.User>> getAllUsers(String userId) async {
    final doc = FirebaseFirestore.instance
        .collection('users')
        .where('userId', isNotEqualTo: userId);
    final snapshot = await doc.get();
    var users =
        snapshot.docs.map((doc) => UserAux.User.fromJson(doc.data())).toList();
    return users;
  }
}
