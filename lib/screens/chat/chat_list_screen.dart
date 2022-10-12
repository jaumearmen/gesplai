import 'package:flutter/material.dart';
import 'package:gesplai/models/user.dart';
import 'package:gesplai/screens/chat/chat_messages.dart';
import 'package:gesplai/screens/widgets/no_xats_screen.dart';
import 'package:gesplai/services/chat_service.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  var userId = 'w78OQolsgjc7bKd6LYZA';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<List<User>>(
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
                        final user = users[index];
                        return SizedBox(
                          height: 75,
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ChatMessages(
                                    user: user,
                                  ),
                                ),
                              );
                            },
                            title: Text(user.name),
                          ),
                        );
                      },
                    ));
                  }
                }
            }
          },
        ),
      ),
    );
  }
}
