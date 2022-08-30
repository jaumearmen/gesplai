import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gesplai/screens/funcions_utils.dart';
import '../../../services/auth_service.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({Key? key}) : super(key: key);

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
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Icon(Icons.add),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        child: const Icon(Icons.logout_rounded),
                      ),
                      onTap: () {
                        authService.signOut();
                      },
                    )
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
            child: const Text(
              'Esplai Sant Joan',
              style: TextStyle(fontSize: 30),
            ),
          ),
          addVerticalSpace(20),
          Container(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: const [
                  TextSpan(
                    text: 'Descripcio: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text:
                          'Esplai catòlic que té com a objectiu que els nens i nenes ho passin molt bé.'),
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
                children: const [
                  TextSpan(
                    text: 'Horari: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: 'Dissabtes de 17:30h a 19:30h'),
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
                children: const [
                  TextSpan(
                    text: 'Lloc: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: 'Carrer Sant Joan, 13'),
                ],
              ),
            ),
          ),
          addVerticalSpace(20),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Message'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Edit Profile'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
