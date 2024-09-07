import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String title;
  final String description;
  final String venue;
  final DateTime date; // Use DateTime type

  Event({
    required this.title,
    required this.description,
    required this.venue,
    required this.date,
  });

  // Convert Firestore document to Event object
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'] as String,
      description: json['description'] as String,
      venue: json['venue'] as String,
      date: (json['date'] as Timestamp).toDate(), // Convert Firestore Timestamp to DateTime
    );
  }

  // Convert Event object to Firestore document
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'venue': venue,
      'date': Timestamp.fromDate(date), // Convert DateTime to Firestore Timestamp
    };
  }
}
