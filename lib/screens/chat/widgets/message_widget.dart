import 'package:flutter/material.dart';
import '../../../models/message.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final bool isMe;

  const MessageWidget({
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final radius = const Radius.circular(12);
    final borderRadius = BorderRadius.all(radius);

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        if (!isMe)
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            constraints: const BoxConstraints(maxWidth: 140),
            decoration: BoxDecoration(
              color: isMe
                  ? Colors.grey[100]
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: isMe
                  ? borderRadius
                      .subtract(BorderRadius.only(bottomRight: radius))
                  : borderRadius
                      .subtract(BorderRadius.only(bottomLeft: radius)),
            ),
            child: buildMessage(),
          ),
      ],
    );
  }

  Widget buildMessage() => Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.message,
            style: TextStyle(color: isMe ? Colors.black : Colors.white),
            textAlign: isMe ? TextAlign.end : TextAlign.start,
          ),
        ],
      );
}
