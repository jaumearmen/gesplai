import 'package:flutter/material.dart';
import 'package:gesplai/models/user.dart';
import 'package:gesplai/screens/chat/chat_messages.dart';
import 'package:gesplai/screens/widgets/no_xats_screen.dart';
import 'package:gesplai/services/chat_service.dart';

class ChatListScreen extends StatefulWidget {
  final String userId;
  const ChatListScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Llistat de xats'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: futureChatList(widget.userId),
      ),
    );
  }

  Widget futureChatList(String userId) {
    return FutureBuilder<List<User>>(
      future: ChatService.getChatUsers(userId),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              print(snapshot.error);
              return const Center(
                  child: Text('Something Went Wrong Try later'));
            } else {
              final users = snapshot.data;

              if (users!.isEmpty) {
                return const NoXatsScreen();
              } else {
                return (ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final userReceiver = users[index];
                    return SizedBox(
                      height: 75,
                      child: ListTile(
                        leading: const Icon(
                          Icons.image,
                          size: 50,
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChatMessages(
                                userReceiver: userReceiver,
                                userWriterId: widget.userId,
                              ),
                            ),
                          );
                        },
                        title: Text(userReceiver.name),
                      ),
                    );
                  },
                ));
              }
            }
        }
      },
    );
  }
}
