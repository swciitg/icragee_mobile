import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icragee_mobile/schedule.dart';

class DataService {
  static Future<List<Schedule>> getSchedules(String day) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('schedules').where('day', isEqualTo: day).get();
    return querySnapshot.docs.map((doc) {
      Schedule schedule = Schedule.fromJson(doc.data() as Map<String, dynamic>);

      DateTime now = DateTime.now();
      String status = (now.isAfter(schedule.startTime) && now.isBefore(schedule.endTime)) ? 'Ongoing' : (now.isBefore(schedule.startTime) ? 'Upcoming' : 'Completed');

      return Schedule(
        title: schedule.title,
        startTime: schedule.startTime,
        endTime: schedule.endTime,
        location: schedule.location,
        day: schedule.day,
        description: schedule.description,
        status: status,
      );
    }).toList();
  }
}
