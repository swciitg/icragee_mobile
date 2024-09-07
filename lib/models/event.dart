class Event {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String venue;
  final String description;
  final int day;

  Event({
    required this.id,
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
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      venue: json['venue'],
      description: json['description'],
      day: json['day'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'venue': venue,
      'description': description,
      'day': day,
    };
  }
}
