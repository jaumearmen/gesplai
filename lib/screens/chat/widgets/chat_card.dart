import 'package:flutter/material.dart';

class ChatCard extends StatefulWidget {
  final String username;
  const ChatCard({Key? key, required this.username}) : super(key: key);

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 90,
        child: Card(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images(esplai2.jpg'),
                  ),
                ),
                Text(widget.username),
                const SizedBox(
                  width: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
