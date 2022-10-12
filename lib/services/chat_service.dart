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
    var querySnapshots = await collection.get();
    List<User> users = [];
    for (var snapshot in querySnapshots.docs) {
      User? u = await UserService.getUser(snapshot.id);
      users.add(u!);
    }
    return users;
  }

  static Future uploadMessage(
      String idUser, String idReceiver, String message, String username) async {
    final refMessages = FirebaseFirestore.instance
        .collection('users/$idUser/chats/$idReceiver/messages');

    final newMessage = Message(
      idWriter: idUser,
      username: username,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());

    final refUsers = FirebaseFirestore.instance.collection('users');
    await refUsers
        .doc(idUser)
        .update({UserField.lastMessageTime: DateTime.now()});
  }

  /*static Future getFutureMessage(String idUser, String idReceiver) {
    final refMessages = FirebaseFirestore.instance
        .collection('users/$idUser/chats/$idReceiver/messages');
  }*/
}
