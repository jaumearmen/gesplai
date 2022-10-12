import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class UserService {
  Future createUserIndividual({
    String? name,
    String? username,
    String? email,
    String? description,
    String? idUser,
  }) async {
    String retVal = 'error';
    try {
      await FirebaseFirestore.instance.collection("users").doc().set({
        'name': name,
        'username': username,
        'email': email,
        'description': description,
      });
    } catch (e) {}
    return retVal;
  }

  Future createUserEsplai({
    required String name,
    String? username,
    required String email,
    String? description,
    String? idEsplai,
    String? localization,
    String? day,
    String? startHour,
    String? endHour,
  }) async {
    String retVal = 'error';
    try {
      await FirebaseFirestore.instance.collection("users").doc().set({
        'name': name,
        'username': username,
        'email': email,
        'description': description,
        'localization': localization,
        'day': day,
        'startHour': startHour,
        'endHour': endHour,
      });
    } catch (e) {}
    return retVal;
  }

  static Future<User?> getUser(String idUser) async {
    final doc = FirebaseFirestore.instance.collection('users').doc(idUser);
    final snapshot = await doc.get();

    if (snapshot.exists) {
      return User.fromJson(snapshot.data()!);
    }
    return null;
  }
}
