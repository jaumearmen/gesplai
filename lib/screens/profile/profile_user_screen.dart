import 'package:flutter/material.dart';
import 'package:gesplai/screens/funcions_utils.dart';
import 'package:gesplai/screens/profile/widgets/pop_up_custom_menu.dart';
import 'package:gesplai/services/user_service.dart';

import 'package:gesplai/models/user.dart' as UserAux;
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';

class ProfileUserScreen extends StatefulWidget {
  const ProfileUserScreen({Key? key}) : super(key: key);

  @override
  State<ProfileUserScreen> createState() => _ProfileUserScreenState();
}

class _ProfileUserScreenState extends State<ProfileUserScreen> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<UserAux.User?>(
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
                    }
                    return Scaffold(
                      body: Container(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    PopUpCustomMenu(menuList: [
                                      const PopupMenuItem(
                                          child: ListTile(
                                        leading: Icon(Icons.add_a_photo),
                                        title: Text('Afegeix una foto'),
                                      )),
                                      PopupMenuItem(
                                          child: ListTile(
                                        leading:
                                            const Icon(Icons.logout_rounded),
                                        title: const Text('Tanca sessió'),
                                        onTap: () {
                                          Navigator.pop(
                                              context, "Tanca sessió");
                                          authService.signOut();
                                        },
                                      )),
                                      const PopupMenuItem(
                                          child: ListTile(
                                        leading: Icon(Icons.app_registration),
                                        title: Text("Inscriure's a una esplai"),
                                      )),
                                    ]),
                                  ],
                                ),
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
                                                'assets/images/profileImg.jpg')),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            addVerticalSpace(10),
                            Container(
                              alignment: Alignment.center,
                              child: const Text(
                                'Maria Bolivar',
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
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
