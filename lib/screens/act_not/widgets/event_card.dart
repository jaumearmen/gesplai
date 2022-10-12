import 'package:flutter/material.dart';
import 'package:gesplai/screens/funcions_utils.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String description;
  const EventCard({Key? key, required this.title, required this.description})
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
                    addVerticalSpace(10),
                    Container(
                      child: Text(description),
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
