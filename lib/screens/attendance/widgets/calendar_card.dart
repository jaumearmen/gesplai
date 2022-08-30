import 'package:flutter/material.dart';

class CalendarCard extends StatelessWidget {
  final int day;
  final String title;
  final bool attendanceMarked;
  const CalendarCard(
      {Key? key,
      required this.day,
      required this.title,
      required this.attendanceMarked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 50,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(color: Colors.blue),
              child: Center(
                child: Text(day.toString()),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        title,
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  Container(
                    child: Container(
                      width: 5,
                      height: 5,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: attendanceMarked ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
