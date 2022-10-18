import 'package:flutter/material.dart';
import 'package:gesplai/screens/attendance/widgets/attendance_card.dart';
import 'package:gesplai/services/attendance_service.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final _attendance = AttendanceService.getAttendancesExample();
  final _usersInscrits = AttendanceService.getUsersInscritsExamples();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Llista d'assistència"),
      ),
      body: Padding(
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
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _attendance.length,
              itemBuilder: (context, index) {
                final name = _usersInscrits[index];
                final vaEsplai = _attendance[index];
                return AttendanceCard(
                  name: name,
                  vaEsplai: vaEsplai,
                  index: index,
                );
              },
            ),
            const SizedBox(
              height: 25,
            ),
            /*Visibility(
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
            ),*/
          ],
        ),
      ),
    );
  }
}
