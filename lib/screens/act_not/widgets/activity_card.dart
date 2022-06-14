import 'package:flutter/material.dart';
import 'package:gesplai/models/activity.dart';
import 'package:gesplai/screens/act_not/activity_detail_screen.dart';
import 'package:gesplai/screens/widgets/icon_and_text.dart';

class ActivityCard extends StatelessWidget {
  final String title;
  final String horari;
  final String hora;
  final String localization;
  final Color color;
  const ActivityCard(
      {Key? key,
      required this.title,
      required this.horari,
      required this.hora,
      required this.localization,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const iconSize = 20.0;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ActivityDetailScreen()),
        );
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: Card(
          shape: Border(left: BorderSide(color: color, width: 5)),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        title,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconAndText(
                      text: horari,
                      icon: Icons.calendar_today_outlined,
                    ),
                    IconAndText(
                      text: hora,
                      icon: Icons.schedule,
                    ),
                    IconAndText(
                      text: localization,
                      icon: Icons.location_on,
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
