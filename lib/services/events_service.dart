import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gesplai/models/event.dart';

class EventsService {
  List<Event> getActivities() {
    Event primera = Event(
      title: "Sortida a l'Esglesia Sant Joan",
      description: 'description',
    );
    Event segona = Event(
      title: 'Anada al Natupark',
      description: 'description',
    );
    return [primera, segona];
  }

  static Stream<List<Event>> getEvents(String idEsplai) =>
      FirebaseFirestore.instance
          .collection('events')
          .where('idEsplai', isEqualTo: idEsplai)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList());

  static Future<void> createEvent(
      {required String title,
      required String description,
      required String idEsplai}) async {
    final docRef = FirebaseFirestore.instance.collection('events');
    docRef.add({
      'idEsplai': idEsplai,
      'title': title,
      'description': description,
    });
  }

  static Future<void> deleteEvent(String title) async {
    /*var ref = FirebaseFirestore.instance
        .collection('events')
        .where('title', isEqualTo: title);
    var snapshots = await ref.get();
    FirebaseFirestore.instance.collection('events').doc().delete();*/
  }
}
