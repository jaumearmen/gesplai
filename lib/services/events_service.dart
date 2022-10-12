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

  static Stream<List<Event>> getEvents(/*String idEsplai*/) =>
      FirebaseFirestore.instance.collection('events').snapshots().map(
          (snapshot) =>
              snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList());
}
