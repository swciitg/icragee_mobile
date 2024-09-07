import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icragee_mobile/models/emergency_contact.dart';
import 'package:icragee_mobile/models/faq.dart';
import 'package:icragee_mobile/models/schedule.dart';
import '../models/event_model.dart';

class DataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to add an event to Firestore
  Future<void> addEvent(Event event) async {
    try {
      await _firestore.collection('events').add(event.toJson());
      print('Event added successfully!');
    } catch (e) {
      print('Failed to add event: $e');
    }
  }

  // Method to fetch all events from Firestore
  Future<List<Event>> getEvents() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('events').get();
      return querySnapshot.docs
          .map((doc) => Event.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Failed to fetch events: $e');
      return [];
    }
  }

  // Method to fetch FAQs from Firestore
  static Future<List<FaqContent>> fetchFaqs() async {
    final collectionSnapshot =
    await FirebaseFirestore.instance.collection('FAQs').get();

    return collectionSnapshot.docs
        .map((doc) => FaqContent.fromJson(doc.data()))
        .toList();
  }

  // Method to fetch emergency contacts by category from Firestore
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

  // Method to submit feedback to Firestore
  static Future<void> submitFeedback({
    required String name,
    required String email,
    required String feedback,
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

  // Method to fetch schedules by day from Firestore
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
