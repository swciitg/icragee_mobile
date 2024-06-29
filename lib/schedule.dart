class Schedule {
  String title;
  String time; // Format: "09:00 - 12:00"
  String location;
  String date; // Format: "yyyy-MM-dd"
  String day;
  String description;
  late String status;

  // Constructor
  Schedule({
    required this.title,
    required this.time,
    required this.location,
    required this.date,
    required this.day,
    required this.description,
  }) {
    _computeStatus();
  }

  // Compute status based on current time
  void _computeStatus() {
    DateTime scheduleDate;
    try {
      scheduleDate = DateTime.parse(date);
    } catch (e) {
      print('Error parsing date: $e');
      status = 'Invalid date';
      return;
    }

    List<String> times = time.split(' - ');
    if (times.length != 2) {
      print('Invalid time format for schedule: $time');
      status = 'Invalid time';
      return;
    }

    try {
      List<String> startTimeParts = times[0].split(':');
      List<String> endTimeParts = times[1].split(':');

      DateTime startTime = DateTime(
          scheduleDate.year,
          scheduleDate.month,
          scheduleDate.day,
          int.parse(startTimeParts[0]),
          int.parse(startTimeParts[1])
      );
      DateTime endTime = DateTime(
          scheduleDate.year,
          scheduleDate.month,
          scheduleDate.day,
          int.parse(endTimeParts[0]),
          int.parse(endTimeParts[1])
      );

      DateTime now = DateTime.now();
      status = (now.isAfter(startTime) && now.isBefore(endTime)) ? 'Upcoming' : (now.isBefore(startTime) ? 'Upcoming' : 'Completed');
    } catch (e) {
      print('Error parsing time: $e');
      status = 'Invalid time';
    }
  }

  // fromJson Constructor
  factory Schedule.fromJson(Map<String, dynamic> json) {
    Schedule schedule = Schedule(
      title: json['title'],
      time: json['time'],
      location: json['location'],
      date: json['date'],
      day: json['day'],
      description: json['description'],
    );
    schedule._computeStatus();
    return schedule;
  }

  // toJson Method
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'time': time,
      'location': location,
      'date': date,
      'day': day,
      'description': description,
      'status': status,
    };
  }
}




