import 'package:flutter/material.dart';
import 'package:gesplai/models/user.dart';
import 'package:gesplai/screens/profile/edit_profile_esplai.dart';
import 'package:gesplai/screens/profile/widgets/pop_up_custom_menu.dart';
import 'package:provider/provider.dart';
import 'package:gesplai/screens/funcions_utils.dart';
import '../../../services/auth_service.dart';

class CustomSliverAppBar extends StatefulWidget {
  final User? user;
  final bool isOther;
  const CustomSliverAppBar({Key? key, this.user, required this.isOther})
      : super(key: key);

  @override
  State<CustomSliverAppBar> createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<CustomSliverAppBar> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            child: Stack(
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
                        leading: const Icon(Icons.logout_rounded),
                        title: const Text('Tanca sessió'),
                        onTap: () {
                          Navigator.pop(context, "Tanca sessió");
                          authService.signOut();
                        },
                      )),
                      PopupMenuItem(
                          child: ListTile(
                        leading: const Icon(Icons.password),
                        title: const Text("Identificador de l'esplai"),
                        onTap: () {
                          openDialog(widget.user!.userId);
                        },
                      )),
                    ]),
                  ],
                ),
                Column(
                  children: [
                    addVerticalSpace(30),
                    Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      alignment: Alignment.center,
                      //constraints: const BoxConstraints(maxHeight: 100, maxWidth: 100),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: const CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                AssetImage('assets/images/profileImg.jpg')),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          addVerticalSpace(10),
          Container(
            alignment: Alignment.center,
            child: Text(
              widget.user!.name,
              style: const TextStyle(fontSize: 30),
            ),
          ),
          addVerticalSpace(20),
          Container(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  const TextSpan(
                    text: 'Descripcio: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: widget.user!.description),
                ],
              ),
            ),
          ),
          addVerticalSpace(10),
          Container(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  const TextSpan(
                    text: 'Horari: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: 'Dissabte de '),
                  TextSpan(text: widget.user!.startHour),
                  const TextSpan(text: ' a '),
                  TextSpan(text: widget.user!.endHour),
                ],
              ),
            ),
          ),
          addVerticalSpace(10),
          Container(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  const TextSpan(
                    text: 'Lloc: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: widget.user!.localization),
                ],
              ),
            ),
          ),
          addVerticalSpace(20),
          Container(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileEsplai(
                      user: widget.user!,
                    ),
                  ),
                );
              },
              child: const Text('Editar Perfil'),
            ),
          ),
        ],
      ),
    );
  }

  Future openDialog(String idEsplai) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Identificador de l'esplai"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                  "Aquest codi permet a altres usuari poder inscriure's i registrar-se en aquest esplai. Es recomana no enviar a usuaris que no s'està segur que s'inscriuran."),
              addVerticalSpace(10),
              Text(idEsplai),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Acceptar'),
            ),
          ],
        ),
      );
}
