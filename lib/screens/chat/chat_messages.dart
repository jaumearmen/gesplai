import 'package:flutter/material.dart';
import 'package:gesplai/models/user.dart';
import 'package:gesplai/screens/chat/widgets/messages_widget.dart';
import 'package:gesplai/screens/chat/widgets/new_message_widget.dart';

class ChatMessages extends StatefulWidget {
  final User userReceiver;
  final String userWriterId;
  const ChatMessages(
      {Key? key, required this.userReceiver, required this.userWriterId})
      : super(key: key);

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userReceiver.name),
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
                  idUser: widget.userWriterId,
                  idReceiver: widget.userReceiver.userId,
                ),
              ),
            ),
            NewMessageWidget(
              idUser: widget.userWriterId,
              idReceiver: widget.userReceiver.userId,
              username: widget.userReceiver.username,
            ),
          ],
        ),
      ),
    );
  }
}
