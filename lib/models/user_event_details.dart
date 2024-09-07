class UserEventDetails {
  final String eventId;
  final DateTime lastUpdated;
  final DateTime startTime;

  const UserEventDetails({
    required this.eventId,
    required this.startTime,
    required this.lastUpdated,
  });

  factory UserEventDetails.fromJson(Map<String, dynamic> json) {
    return UserEventDetails(
      eventId: json['eventId'],
      startTime: DateTime.parse(json['startTime']),
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'startTime': startTime.toString(),
      'lastUpdated': lastUpdated.toString(),
    };
  }
}
