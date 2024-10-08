class Event {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String venue;
  final String description;
  final int day;

  Event({
    this.id = "",
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.venue,
    required this.description,
    required this.day,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      startTime: DateTime.parse(json['startTime']).toLocal(),
      endTime: DateTime.parse(json['endTime']).toLocal(),
      venue: json['venue'],
      description: json['description'],
      day: json['day'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'startTime': startTime.toUtc().toString(),
      'endTime': endTime.toUtc().toString(),
      'venue': venue,
      'description': description,
      'day': day,
    };
  }

  Event copyWith({
    String? id,
    String? title,
    DateTime? startTime,
    DateTime? endTime,
    String? venue,
    String? description,
    int? day,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      venue: venue ?? this.venue,
      description: description ?? this.description,
      day: day ?? this.day,
    );
  }
}
