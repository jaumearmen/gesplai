import '../screens/widgets/utils.dart';

class UserField {
  static const String lastMessageTime = 'lastMessageTime';
}

class User {
  final String idUser;
  final String name;
  final String username;
  final String email;
  final String? description;
  final String? idEsplai;
  final String? localization;
  final String? day;
  final String? startHour;
  final String? endHour;
  final DateTime? lastMessageTime;

  User({
    required this.idUser,
    required this.name,
    required this.username,
    required this.email,
    this.description,
    this.idEsplai,
    this.localization,
    this.day,
    this.startHour,
    this.endHour,
    this.lastMessageTime,
  });

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'name': name,
        'username': username,
        'email': email,
        'description': description,
        'idEsplai': idEsplai,
        'localization': localization,
        'day': day,
        'startHour': startHour,
        'endHour': endHour,
        'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime!),
      };

  static User fromJson(Map<String, dynamic> json) => User(
        idUser: json['idUser'],
        name: json['name'],
        username: json['username'],
        email: json['email'],
        description: json['description'],
        idEsplai: json['idEsplai'],
        localization: json['localization'],
        day: json['day'],
        startHour: json['startHour'],
        endHour: json['endHour'],
        lastMessageTime: Utils.toDateTime(json['lastMessageTime']),
      );
}
