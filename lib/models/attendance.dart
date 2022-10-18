class Attendance {
  final List<String> usersInscrits;
  final List<bool> attendance;

  Attendance({
    required this.usersInscrits,
    required this.attendance,
  });

  Map<String, dynamic> toJson() => {
        'userInscrits': usersInscrits,
        'attendance': attendance,
      };

  static Attendance fromJson(Map<String, dynamic> json) => Attendance(
        usersInscrits: json['usersInscrits'] as List<String>,
        attendance: json['attendance'],
      );
}
