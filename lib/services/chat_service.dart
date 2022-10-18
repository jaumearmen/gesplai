import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gesplai/models/user.dart';
import 'package:gesplai/models/user_individual.dart';
import 'package:gesplai/services/user_service.dart';

import '../models/message.dart';

class ChatService {
  static Stream<List<UserIndividual>> getUsersIndividuals() =>
      FirebaseFirestore.instance
          .collection('users')
          .orderBy(UserIndividualField.lastMessageTime, descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => UserIndividual.fromJson(doc.data()))
              .toList());

  static Stream<List<Message>> getMessages(String idUser, String idReceiver) =>
      FirebaseFirestore.instance
          .collection('users/$idUser/chats/$idReceiver/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Message.fromJson(doc.data()))
              .toList());

  static Future<List<User>> getChatUsers(String idUser) async {
    var collection =
        FirebaseFirestore.instance.collection('users/$idUser/chats');
    var querySnapshots =
        await collection.get(); // Llista de documents de conversa
    List<User> users = [];
    for (var snapshot in querySnapshots.docs) {
      User? u = await UserService.getUserById(snapshot.data()['idReceiver']);
      users.add(u);
    }
    return users;
  }

  static Future createMessage(
      {required String idUser, required String idReceiver}) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(idUser)
        .collection('chats')
        .doc(idReceiver)
        .set(
      {'idReceiver': idReceiver},
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(idReceiver)
        .collection('chats')
        .doc(idUser)
        .set(
      {'idReceiver': idUser},
    );
  }

  static Future uploadMessage(
      String idUser, String idReceiver, String message, String username) async {
    final refMessages1 = FirebaseFirestore.instance
        .collection('users/$idUser/chats/$idReceiver/messages');
    final refMessages2 = FirebaseFirestore.instance
        .collection('users/$idReceiver/chats/$idUser/messages');

    final newMessage1 = Message(
      idWriter: idUser,
      username: username,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages1.add(newMessage1.toJson());

    final newMessage2 = Message(
      idWriter: idUser,
      username: username,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages2.add(newMessage2.toJson());

    final refUsers = FirebaseFirestore.instance.collection('users');
    await refUsers
        .doc(idUser)
        .update({UserField.lastMessageTime: DateTime.now()});
    await refUsers
        .doc(idReceiver)
        .update({UserField.lastMessageTime: DateTime.now()});
  }

  /*static Future getFutureMessage(String idUser, String idReceiver) {
    final refMessages = FirebaseFirestore.instance
        .collection('users/$idUser/chats/$idReceiver/messages');
  }*/
}
