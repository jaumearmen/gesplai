import 'package:flutter/material.dart';
import 'package:gesplai/models/user.dart';
import 'package:gesplai/screens/chat/widgets/messages_widget.dart';
import 'package:gesplai/screens/chat/widgets/new_message_widget.dart';
import 'package:gesplai/globals.dart' as globals;

class ChatMessages extends StatefulWidget {
  final User user;
  const ChatMessages({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.name),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: MessagesWidget(
                  idUser: globals.uid,
                  idReceiver: widget.user.userId,
                ),
              ),
            ),
            NewMessageWidget(
              idUser: globals.uid,
              idReceiver: widget.user.userId,
              username: widget.user.username,
            ),
          ],
        ),
      ),
    );
  }
}
