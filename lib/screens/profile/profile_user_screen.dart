import 'package:flutter/material.dart';
import 'package:gesplai/screens/funcions_utils.dart';
import 'package:gesplai/screens/profile/edit_profile_user.dart';
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
  void initState() {
    super.initState();
    setState(() {});
  }

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
                                    popUpMenu(
                                      hasEsplai: _user!.idEsplai != '',
                                      idUser: _user.userId,
                                    ),
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
                                _user.name,
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditProfileUser(user: _user),
                                  ),
                                );
                              },
                              child: const Text('Editar perfil'),
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

  Future openDialog(String userId) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Desregistre de l'esplai"),
          content: const Text(
              "Actualment estàs registrat a un esplai, si acceptes, deixaràs de tenir accés a l'informació de les activitats i assistència d'aquest."),
          actions: [
            TextButton(
              onPressed: () {
                UserService.unregisterEsplai(idUser: userId);
                Navigator.pop(context);
                setState(() {});
              },
              child: const Text('Acceptar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel·lar'),
            ),
          ],
        ),
      );

  Widget popUpMenu({required bool hasEsplai, required String idUser}) {
    final authService = Provider.of<AuthService>(context);
    if (hasEsplai) {
      return PopUpCustomMenu(menuList: [
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.add_a_photo),
            title: const Text('Afegeix una foto'),
            onTap: () {
              Navigator.pop(context, "Afegeix una foto");
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text('Tanca sessió'),
            onTap: () {
              Navigator.pop(context, "Tanca sessió");
              authService.signOut();
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.app_registration),
            title: const Text("Desregistrar-se de l'esplai"),
            onTap: () {
              Navigator.pop(context, "Desregistrar-se de l'esplai");
              openDialog(idUser);
            },
          ),
        ),
      ]);
    } else {
      return PopUpCustomMenu(menuList: [
        const PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.add_a_photo),
            title: Text('Afegeix una foto'),
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text('Tanca sessió'),
            onTap: () {
              Navigator.pop(context, "Tanca sessió");
              authService.signOut();
            },
          ),
        ),
      ]);
    }
  }
}
