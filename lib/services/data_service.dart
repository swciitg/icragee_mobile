import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icragee_mobile/models/emergency_contact.dart';
import 'package:icragee_mobile/models/faq.dart';
import 'package:icragee_mobile/models/schedule.dart';

class DataService {
  static Future<List<FaqContent>> fetchFaqs() async {
    final collectionSnapshot = await FirebaseFirestore.instance.collection('FAQs').get();

    return collectionSnapshot.docs.map((doc) => FaqContent.fromJson(doc.data())).toList();
  }

  static Future<List<EmergencyContact>> fetchContactsByCategory(String category) async {
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

  static Future<List<Schedule>> getDayWiseEvents(int day) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('events').where('day', isEqualTo: day).get();
    return querySnapshot.docs.map((doc) {
      return Schedule.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<void> addEvent(Schedule event) async {
    await FirebaseFirestore.instance.collection('events').add({
      'title': event.title,
      'startTime': event.startTime,
      'endTime': event.endTime,
      'location': event.location,
      'description': event.description,
      'day': event.day,
    });
  }

  Future<List<Schedule>> getEvents() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('events').get();
    return snapshot.docs.map((doc) {
      return Schedule.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  static Stream<List<String>> getUserEventIds(String email) {
    return FirebaseFirestore.instance.collection('users').doc(email).snapshots().map((doc) {
      return List<String>.from(doc['events']);
    });
  }

  static Stream<Schedule> getEventById(String id) {
    return FirebaseFirestore.instance.collection('events').doc(id).snapshots().map((doc) {
      return Schedule.fromJson(doc.data() as Map<String, dynamic>);
    });
  }

  static Future<void> addEventToUser(String email, String eventId) async {
    DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(email);
    DocumentSnapshot userSnapshot = await userDoc.get();

    if (userSnapshot.exists) {
      List<String> events = List<String>.from(userSnapshot['events']);
      if (events.contains(eventId)) return;
      events.add(eventId);
      await userDoc.update({'events': events});
    } else {
      await userDoc.set({
        'events': [eventId]
      });
    }
  }
}
