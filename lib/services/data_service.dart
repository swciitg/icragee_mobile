import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icragee_mobile/models/emergency_contact.dart';
import 'package:icragee_mobile/models/faq.dart';
import 'package:icragee_mobile/models/schedule.dart';

class DataService {
  static Future<List<FaqContent>> fetchFaqs() async {
    final collectionSnapshot =
        await FirebaseFirestore.instance.collection('FAQs').get();

    return collectionSnapshot.docs
        .map((doc) => FaqContent.fromJson(doc.data()))
        .toList();
  }

  static Future<List<EmergencyContact>> fetchContactsByCategory(
      String category) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('important_contacts')
          .where('category', isEqualTo: category)
          .get();

      // Convert each document into a Contact object
      List<EmergencyContact> contacts = querySnapshot.docs.map((doc) {
        return EmergencyContact.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return contacts;
    } catch (e) {
      throw Exception('Error fetching contacts: $e');
    }
  }

  static Future<void> submitFeedback({
    required var name,
    required var email,
    required var feedback,
  }) async {
    try {
      await FirebaseFirestore.instance.collection("feedback").add({
        "name": name,
        "email": email,
        "feedback": feedback,
      });
    } catch (error) {
      throw ('Failed to submit feedback: $error');
    }
  }

  static Future<List<Schedule>> getSchedules(int day) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('schedules')
        .where('day', isEqualTo: day)
        .get();
    return querySnapshot.docs.map((doc) {
      return Schedule.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
