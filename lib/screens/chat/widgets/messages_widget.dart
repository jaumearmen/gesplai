import 'package:flutter/material.dart';
import 'package:gesplai/services/chat_service.dart';
import '../../../globals.dart' as globals;
import '../../../models/message.dart';
import 'message_widget.dart';

class MessagesWidget extends StatelessWidget {
  final String idUser;
  final String idReceiver;

  const MessagesWidget({
    required this.idUser,
    required this.idReceiver,
  });

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Message>>(
        stream: ChatService.getMessages(idUser, idReceiver),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later');
              } else {
                final messages = snapshot.data;

                return messages!.isEmpty
                    ? buildText('Say Hi..')
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];

                          return MessageWidget(
                            message: message,
                            isMe: message.idWriter == globals.uid,
                          );
                        },
                      );
              }
          }
        },
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      );
}
