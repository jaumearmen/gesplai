import '../screens/widgets/utils.dart';

class UserIndividualField {
  static const String lastMessageTime = 'lastMessageTime';
}

class UserIndividual {
  final String? name;
  final String? username;
  final String? email;
  final String? description;
  final String? idUser;
  final DateTime? lastMessageTime;

  UserIndividual({
    this.name,
    this.username,
    this.email,
    this.description,
    this.idUser,
    this.lastMessageTime,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'username': username,
        'email': email,
        'description': description,
        'idUser': idUser,
        'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime!),
      };

  static UserIndividual fromJson(Map<String, dynamic> json) => UserIndividual(
        name: json['name'],
        username: json['username'],
        email: json['email'],
        description: json['description'],
        idUser: json['idUser'],
        lastMessageTime: Utils.toDateTime(json['lastMessageTime']),
      );

  toList() {}
}
