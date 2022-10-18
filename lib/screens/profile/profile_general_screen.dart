import 'package:flutter/material.dart';
import 'package:gesplai/screens/profile/profile_esplai_screen.dart';
import 'package:gesplai/screens/profile/profile_user_screen.dart';

import '../../models/user.dart';
import '../../services/user_service.dart';

class ProfileGeneralScreen extends StatefulWidget {
  const ProfileGeneralScreen({Key? key}) : super(key: key);

  @override
  State<ProfileGeneralScreen> createState() => _ProfileGeneralScreenState();
}

class _ProfileGeneralScreenState extends State<ProfileGeneralScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<User?>(
          future: UserService.getUser(),
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
                  } else {
                    return _user!.isEsplai
                        ? const ProfileEsplaiScreen()
                        : const ProfileUserScreen();
                  }
                }
            }
          }),
    );
  }
}
