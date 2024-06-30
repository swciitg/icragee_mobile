import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Schedule {
  String title;
  DateTime startTime; // Changed from String to DateTime
  DateTime endTime; // Changed from String to DateTime
  String location;
  //String date; // Format: "yyyy-MM-dd"
  String day;
  String description;
  late String status;
  late String startTiming;
  late String endTiming;

  // Constructor
  Schedule({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.location,
    //required this.date,
    required this.day,
    required this.description,
    required this.status,
  }) {
    startTiming = DateFormat('HH:mm').format(startTime);
    endTiming = DateFormat('HH:mm').format(endTime);
  }

  // FromJson Constructor
  factory Schedule.fromJson(Map<String, dynamic> json) {
    DateTime startTime = (json['startTime'] as Timestamp).toDate();
    DateTime endTime = (json['endTime'] as Timestamp).toDate();
    return Schedule(
      title: json['title'],
      startTime: startTime,
      endTime: endTime,
      location: json['location'],
      //date: json['date'],
      day: json['day'],
      description: json['description'],
      status: '', // This will be computed in the DataService
    );
  }

  // ToJson Method
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'startTime': startTime,
      'endTime': endTime,
      'location': location,
      //'date': date,
      'day': day,
      'description': description,
    };
  }
}
