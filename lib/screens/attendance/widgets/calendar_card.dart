import 'package:flutter/material.dart';

class CalendarCard extends StatelessWidget {
  const CalendarCard({Key? key}) : super(key: key);

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
              child: const Center(
                child: Text('18'),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: const Text(
                        "Dia d'esplai",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  Container(
                    child: Container(
                      width: 5,
                      height: 5,
                      margin: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
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
