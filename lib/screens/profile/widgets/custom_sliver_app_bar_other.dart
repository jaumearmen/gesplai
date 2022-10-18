import 'package:flutter/material.dart';
import 'package:gesplai/models/attendance.dart';
import 'package:gesplai/models/user.dart';
import 'package:gesplai/screens/chat/chat_messages.dart';
import 'package:gesplai/services/attendance_service.dart';
import 'package:gesplai/services/user_service.dart';
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
  late TextEditingController controller;
  late User userFirebase;
  late bool hasEsplai;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> getUser() async {
    userFirebase = (await UserService.getUser())!;
    if (userFirebase != null) {
      hasEsplai = userFirebase.idEsplai != '';
    } else {
      hasEsplai = true;
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
    controller = TextEditingController();
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                widget.isOther
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatMessages(
                                userReceiver: widget.user!,
                                userWriterId: userFirebase.userId,
                              ),
                            ),
                          );
                        },
                        child: const Text('Missatge'),
                      )
                    : ElevatedButton(
                        onPressed: () {},
                        child: const Text('Edit Profile'),
                      ),
                ElevatedButton(
                  onPressed: () {
                    openDialog(widget.user!.name);
                  },
                  child: const Text("Inscriure's"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future openDialog(String esplaiName) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Registra't a l'esplai $esplaiName"),
          content: hasEsplai
              ? const Text('Ja estàs inscrit a un esplai!')
              : TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                      hintText: "Escriu el codi de l'esplai"),
                  autofocus: true,
                ),
          actions: [
            TextButton(
              onPressed: () {
                if (hasEsplai) {
                  Navigator.pop(context);
                } else {
                  validateCode(controller.text);
                  Navigator.pop(context);
                }
              },
              child: hasEsplai
                  ? const Text('Acceptar')
                  : const Text("Inscriure's"),
            ),
          ],
        ),
      );

  Future<void> validateCode(String code) async {
    bool isValid = await UserService.validateEsplai(idEsplai: code);
    if (isValid) {
      await UserService.registerEsplai(
        idEsplai: code,
        idUser: userFirebase.userId,
      );
      Attendance attendance =
          (await AttendanceService.getAttendanceFuture(code))!;
      attendance.usersInscrits.add(userFirebase.userId);
      attendance.attendance.add(false);
      var usersInscrits = attendance.usersInscrits;
      var attendanceAux = attendance.attendance;
      AttendanceService.addDeleteUserAttendance(
          usersInscrits: usersInscrits,
          attendance: attendanceAux,
          idEsplai: code);
      setState(() {
        hasEsplai = true;
      });
    }
    Navigator.pop(context);
  }
}
