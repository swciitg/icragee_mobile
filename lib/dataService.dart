import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icragee_mobile/schedule.dart';

class DataService {
  final CollectionReference scheduleCollection = FirebaseFirestore.instance.collection('schedules');

  Future<List<Schedule>> getSchedules(String day) async {
    QuerySnapshot querySnapshot = await scheduleCollection.where('day', isEqualTo: day).get();
    return querySnapshot.docs.map((doc) {
      return Schedule.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
