class Event {
  final String title;
  final String description;

  Event({
    required this.title,
    required this.description,
  });

  static Event fromJson(Map<String, dynamic> json) => Event(
        title: json['title'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
      };
}
