import 'package:flutter/material.dart';
import 'package:gesplai/models/user.dart';
import 'package:gesplai/screens/chat/chat_messages.dart';
import 'package:provider/provider.dart';
import 'package:gesplai/screens/funcions_utils.dart';
import '../../../services/auth_service.dart';

class CustomSliverAppBarOther extends StatefulWidget {
  final User? user;
  final bool isOther;
  const CustomSliverAppBarOther({Key? key, this.user, required this.isOther})
      : super(key: key);

  @override
  State<CustomSliverAppBarOther> createState() =>
      _CustomSliverAppBarOtherState();
}

class _CustomSliverAppBarOtherState extends State<CustomSliverAppBarOther> {
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                widget.isOther
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatMessages(
                                      user: widget.user!,
                                    )),
                          );
                        },
                        child: const Text('Message'),
                      )
                    : ElevatedButton(
                        onPressed: () {},
                        child: const Text('Edit Profile'),
                      ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Inscriure's"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
