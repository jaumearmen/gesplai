import 'package:flutter/material.dart';
import 'package:gesplai/screens/chat/chat_messages.dart';
import 'package:gesplai/screens/funcions_utils.dart';
import 'package:gesplai/services/user_service.dart';

import 'package:gesplai/models/user.dart' as UserAux;
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';

class ProfileOtherUserScreen extends StatefulWidget {
  final String userId;
  final String otherUserId;
  const ProfileOtherUserScreen(
      {Key? key, required this.userId, required this.otherUserId})
      : super(key: key);

  @override
  State<ProfileOtherUserScreen> createState() => _ProfileOtherUserScreenState();
}

class _ProfileOtherUserScreenState extends State<ProfileOtherUserScreen> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<UserAux.User?>(
            future: UserService.getUserById(widget.otherUserId),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text('Something Went Wrong Try later'));
                  } else {
                    final _user = snapshot.data;
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Scaffold(
                      body: Container(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Column(
                                  children: [
                                    addVerticalSpace(30),
                                    Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle),
                                      alignment: Alignment.center,
                                      //constraints: const BoxConstraints(maxHeight: 100, maxWidth: 100),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: const CircleAvatar(
                                          radius: 60,
                                          backgroundImage: AssetImage(
                                            'assets/images/profileImg.jpg',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            addVerticalSpace(20),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                _user!.name,
                                style: const TextStyle(fontSize: 30),
                              ),
                            ),
                            addVerticalSpace(5),
                            Text(
                              _user.username,
                              style: TextStyle(
                                color: Colors.grey[350],
                              ),
                            ),
                            addVerticalSpace(20),
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: [
                                  const TextSpan(
                                    text: 'Email: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(text: _user.email),
                                ],
                              ),
                            ),
                            addVerticalSpace(20),
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: [
                                  const TextSpan(
                                    text: 'Descripcio: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(text: _user.description),
                                ],
                              ),
                            ),
                            addVerticalSpace(20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatMessages(
                                      userReceiver: _user,
                                      userWriterId: widget.userId,
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Message'),
                            )
                          ],
                        ),
                      ),
                    );
                  }
              }
            }),
      ),
    );
  }
}
