import 'package:flutter/material.dart';
import 'package:gesplai/models/activity.dart';
import 'package:gesplai/screens/act_not/edit_activity_screen.dart';
import 'package:gesplai/screens/act_not/widgets/activity_card.dart';
import 'package:gesplai/screens/funcions_utils.dart';
import 'package:gesplai/services/activities_service.dart';
import 'package:gesplai/globals.dart' as globals;
import 'package:provider/provider.dart';

class ActNotListScreen extends StatefulWidget {
  const ActNotListScreen({Key? key}) : super(key: key);

  @override
  State<ActNotListScreen> createState() => _ActNotListScreenState();
}

class _ActNotListScreenState extends State<ActNotListScreen> {
  @override
  Widget build(BuildContext context) {
    final activitiesService = Provider.of<ActivitiesService>(context);
    List<Activity> activities = activitiesService.getActivities();
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const EditActivitySceren()),
            );
          },
          backgroundColor: globals.COLOR_BLUE,
          child: const Icon(Icons.add),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: activities.length,
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  ActivityCard(
                    title: activities[index].title,
                    localization: activities[index].localization,
                    hora: activities[index].startHour,
                    horari: activities[index].date,
                    color: chooseColor(activities[index]),
                  ),
                  addVerticalSpace(10),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  chooseColor(Activity activity) {
    // Aqui he de fer que si la activity falta menys d'un dia: color vermell, menys de 4 dies: color groc, else: verd
    return Colors.green;
  }
}
