import 'package:gesplai/models/activity.dart';

class ActivitiesService {
  List<Activity> getActivities() {
    Activity primera = Activity(
      '0',
      "Sortida a l'Esglesia de Sant Joan WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW",
      'description',
      'Carrer Àngel guimerà num.8',
      '18:00h',
      '20:00h',
      '18 de Desembre de 2022',
    );
    Activity segona = Activity(
      '1',
      'Anada al Natupark',
      'description',
      'Martorell',
      '12:00h',
      '18:00h',
      '12 de Gener de 2022',
    );
    return [primera, segona];
  }
}
