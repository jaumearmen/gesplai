import 'package:flutter/material.dart';
import 'package:gesplai/models/attendance.dart';
import 'package:gesplai/screens/attendance/widgets/attendance_card.dart';
import 'package:gesplai/screens/widgets/no_esplai_screen.dart';
import 'package:gesplai/services/attendance_service.dart';
import 'package:gesplai/services/user_service.dart';

import '../../models/user.dart';

class AttendanceScreen2 extends StatefulWidget {
  final String userId;
  const AttendanceScreen2({Key? key, required this.userId}) : super(key: key);

  @override
  State<AttendanceScreen2> createState() => _AttendanceScreen2State();
}

class _AttendanceScreen2State extends State<AttendanceScreen2> {
  String _idEsplai = '';
  bool teEsplai = false;
  bool esEsplai = false;

  Future<void> getUser() async {
    User? aux = await UserService.getUser();
    if (aux!.isEsplai) {
      setState(() {
        _idEsplai = aux.userId;
        esEsplai = true;
      });
    } else if (aux.idEsplai == '') {
      setState(() {
        _idEsplai = '';
        teEsplai = false;
      });
    } else {
      setState(() {
        _idEsplai = aux.idEsplai!;
        teEsplai = true;
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getUser();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: teEsplai
            ? Padding(
                padding: const EdgeInsets.all(20),
                child: StreamBuilder<Attendance>(
                  stream: AttendanceService.getAttendance(_idEsplai),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return const Center(
                        child: Text('Something Went Wrong Try later'),
                      );
                    } else {
                      final attendanceDoc = snapshot.data;
                      if (!teEsplai || attendanceDoc == null) {
                        return const NoEsplaiScreen();
                      } else {
                        if (attendanceDoc.attendance.isEmpty) {
                          //NULL CHECK
                          return const Center(
                            child:
                                Text("NO TENS CAP USUARI REGISTRAT A L'ESPLAI"),
                          );
                        } else {
                          return Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width,
                                  ),
                                  child: const Text(
                                    'ASSISTÈNCIA',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                ListView.builder(
                                  itemCount: attendanceDoc.attendance.length,
                                  itemBuilder: (context, index) {
                                    final name =
                                        attendanceDoc.usersInscrits[index];
                                    final vaEsplai =
                                        attendanceDoc.attendance[index];
                                    return AttendanceCard(
                                      name: name,
                                      vaEsplai: vaEsplai,
                                      //idEsplai: _idEsplai,
                                      index: index,
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Visibility(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      AttendanceService.resetAttendance(
                                        _idEsplai,
                                        attendanceDoc.usersInscrits.length,
                                      );
                                    },
                                    child: const Text('Pròxim dia'),
                                  ),
                                  visible: esEsplai,
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    }
                  },
                ),
              )
            : const NoEsplaiScreen());
  }
}
