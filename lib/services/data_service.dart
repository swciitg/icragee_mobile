import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icragee_mobile/models/emergency_contact.dart';
import 'package:icragee_mobile/models/faq.dart';
import 'package:icragee_mobile/models/schedule.dart';
import '../models/event_model.dart';
import 'package:icragee_mobile/models/user_event_details.dart';

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
    final collectionSnapshot = await FirebaseFirestore.instance.collection('FAQs').get();

    return collectionSnapshot.docs.map((doc) => FaqContent.fromJson(doc.data())).toList();
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


  static Future<List<Schedule>> getDayWiseEvents(int day) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('events').where('day', isEqualTo: day).get();
    return querySnapshot.docs.map((doc) {
      return Schedule.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<void> addEvent(Schedule event) async {
    await FirebaseFirestore.instance.collection('events').add(event.toJson());
  }

  Future<List<Schedule>> getEvents() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('events').get();
    return snapshot.docs.map((doc) {
      return Schedule.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  static Stream<List<UserEventDetails>> getUserEventIds(String email) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .collection("events")
        .orderBy('startTime')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserEventDetails.fromJson(doc.data());
      }).toList();
    });
  }

  static Stream<Schedule> getEventById(String id) {
    return FirebaseFirestore.instance.collection('events').doc(id).snapshots().map((doc) {
      return Schedule.fromJson(doc.data() as Map<String, dynamic>);
    });
  }

  static Future<void> addEventToUser(String email, Schedule event) async {
    final collection =
        FirebaseFirestore.instance.collection('users').doc(email).collection("events");
    final newDoc = collection.doc(event.id);
    if (await newDoc.get().then((doc) => doc.exists)) {
      return;
    }
    await newDoc.set(UserEventDetails(
      eventId: event.id,
      startTime: event.startTime,
      lastUpdated: event.lastUpdated,
    ).toJson());
  }

  static Future<void> updateUserEvent(String email, Schedule event) async {
    final collection =
        FirebaseFirestore.instance.collection('users').doc(email).collection("events");
    final doc = collection.doc(event.id);
    await doc.update(UserEventDetails(
      eventId: event.id,
      startTime: event.startTime,
      lastUpdated: event.lastUpdated,
    ).toJson());
  }
}
