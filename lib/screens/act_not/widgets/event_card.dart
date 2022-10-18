import 'package:flutter/material.dart';
import 'package:gesplai/services/events_service.dart';

import '../event_detail_screen.dart';

class EventCard extends StatefulWidget {
  final String title;
  final String description;
  final String idEsplai;
  final bool isEsplai;
  const EventCard({
    Key? key,
    required this.title,
    required this.description,
    required this.idEsplai,
    required this.isEsplai,
  }) : super(key: key);

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: 5,
                  color: Colors.green,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.title,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Visibility(
                  visible: widget.isEsplai,
                  child: IconButton(
                    onPressed: () {
                      openDialog(widget.idEsplai);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EventDetailScreen(
              title: widget.title,
              description: widget.description,
            ),
          ),
        );
      },
    );
  }

  Future openDialog(String idEsplai) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Eliminar esdeveniment"),
          content: const Text(
              "Estàs segur que vols eliminar aquest esdeveniment? Si acceptes ja no el podràs recuperar."),
          actions: [
            TextButton(
              onPressed: () {
                EventsService.deleteEvent(idEsplai);
                Navigator.pop(context);
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
}
