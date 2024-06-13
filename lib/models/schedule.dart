// import 'package:uuid/uuid.dart';

// var uuid = const Uuid();

class Schedule {
  final String id;
  final String title;
  final String description;
  final List<String> speakerName;
  final double timeStart;
  final double timeEnd;

  Schedule({
    required this.title,
    required this.description,
    required this.speakerName,
    required this.timeStart,
    required this.timeEnd,
  }) : id = '0';
}
