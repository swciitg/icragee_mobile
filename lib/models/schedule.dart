

class Schedule {
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final String description;
  final int day;

  Schedule(
      {required this.title,
      required this.startTime,
      required this.endTime,
      required this.location,
      required this.description,
      required this.day});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      title: json['title'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      location: json['location'],
      description: json['description'],
      day: json['day'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'location': location,
      'description': description,
      'day': day,
    };
  }
}
