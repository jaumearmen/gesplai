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

  static Future<UserAux.User> getUserById(String id) async {
    final doc = FirebaseFirestore.instance
        .collection('users')
        .where('userId', isEqualTo: id);
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

  static Future<void> updateUser({
    required String name,
    required String username,
    required String email,
    required String description,
    required String localization,
    required String day,
    required String startHour,
    required String endHour,
    required String userId,
  }) async {
    final docRef = FirebaseFirestore.instance.collection('users').doc(userId);
    docRef.update({
      'name': name,
      'username': username,
      'email': email,
      'description': description,
      'localization': localization,
      'day': day,
      'startHour': startHour,
      'endHour': endHour,
    });
  }

  static Future<void> registerEsplai(
      {required String idEsplai, required String idUser}) async {
    final docRef = FirebaseFirestore.instance.collection('users').doc(idUser);
    docRef.update({
      'idEsplai': idEsplai,
    });
  }

  static Future<void> unregisterEsplai({required String idUser}) async {
    final docRef = FirebaseFirestore.instance.collection('users').doc(idUser);
    docRef.update({
      'idEsplai': '',
    });
  }

  static Future<bool> validateEsplai({required String idEsplai}) async {
    final doc = FirebaseFirestore.instance.collection('users').doc(idEsplai);
    final snapshot = await doc.get();

    if (snapshot.exists) {
      return true;
    }
    return false;
  }
}
