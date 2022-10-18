import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gesplai/models/attendance.dart';

class AttendanceService {
  static Stream<Attendance> getAttendance(String idEsplai) =>
      FirebaseFirestore.instance
          .collection('attendance')
          .doc(idEsplai)
          .snapshots()
          .map((snapshot) => Attendance.fromJson(snapshot.data()!));

  static Future<Attendance?> getAttendanceFuture(String idEsplai) async {
    var snapshot = await FirebaseFirestore.instance
        .collection('attendance')
        .doc(idEsplai)
        .get();
    if (snapshot.exists) {
      return Attendance.fromJson(snapshot.data()!);
    }
    return null;
  }

  /*return FirebaseFirestore.instance
          .collection('events')
          .where('idEsplai', isEqualTo: idEsplai)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => Attendance.fromJson(doc.data())).toList());*/

  static Future<void> updateAttendance(
      String idEsplai, bool vaEsplai, int index) async {
    final docRef =
        FirebaseFirestore.instance.collection('attendance').doc(idEsplai);

    docRef.update({
      'attendance[$index]': vaEsplai,
    });
  }

  static Future<void> resetAttendance(String idEsplai, int length) async {
    final docRef =
        FirebaseFirestore.instance.collection('attendance').doc(idEsplai);

    for (int i = 0; i < length; i++) {
      docRef.update({
        'attendance[$i]': false,
      });
    }
  }

  static Future<void> createAttendance({
    required List<String> usersInscrits,
    required List<bool> attendance,
    required String idEsplai,
  }) async {
    final docRef =
        FirebaseFirestore.instance.collection('attendance').doc(idEsplai);
    docRef.set({
      'usersInscrits': usersInscrits,
      'attendance': attendance,
    });
  }

  static Future<void> addDeleteUserAttendance({
    required List<String> usersInscrits,
    required List<bool> attendance,
    required String idEsplai,
  }) async {
    final docRef =
        FirebaseFirestore.instance.collection('attendance').doc(idEsplai);
    docRef.update({
      'usersInscrits': usersInscrits,
      'attendance': attendance,
    });
  }

  static List<String> getUsersInscritsExamples() {
    var usersInscrits = [
      'josepmaria',
      'viscaelbarça',
      'dolors24',
      'jaumearmen',
      'marcvizca123'
    ];
    return usersInscrits;
  }

  static List<bool> getAttendancesExample() {
    return [true, false, false, true, true];
  }
}
