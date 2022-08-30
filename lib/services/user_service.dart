import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gesplai/models/user.dart';

class UserService {
  Future createUser(
      {required String name,
      String? username,
      required String email,
      String? description,
      String? profilePhotoUrl,
      String? idEsplai,
      int? phoneNumber}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    final user = User(
        name: name,
        username: username,
        email: email,
        description: description,
        profilePhotoUrl: profilePhotoUrl,
        idEsplai: idEsplai,
        phoneNumber: phoneNumber);

    final json = user.toJson();

    await docUser.set(json);

    /*final json = {
      'name': name,
      'username': username,
      'email': email,
      'description': description,
      'profilePhotoUrl': profilePhotoUrl,
      'idEsplai': idEsplai,
      'phoneNumber': phoneNumber,
    };

    await docUser.set(json);*/
  }
}
