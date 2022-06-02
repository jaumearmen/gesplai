import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final String title;
  final String horari;
  final String hora;
  final String localization;
  const ActivityCard(
      {Key? key,
      required this.title,
      required this.horari,
      required this.hora,
      required this.localization})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Card(
          child: Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: 5,
                color: Colors.green,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      child: Text(title, style: const TextStyle(fontSize: 20)),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_outlined),
                        Container(
                          child: Text(horari),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.schedule),
                        Container(
                          child: Text(hora),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on),
                        Container(
                          child: Text(localization),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
