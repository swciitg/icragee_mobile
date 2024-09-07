import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icragee_mobile/models/emergency_contact.dart';
import 'package:icragee_mobile/models/event.dart';
import 'package:icragee_mobile/models/faq.dart';
import 'package:icragee_mobile/models/user_event_details.dart';

class DataService {
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

  static Future<List<Event>> getDayWiseEvents(int day) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('events')
        .where('day', isEqualTo: day)
        .get();
    return querySnapshot.docs.map((doc) {
      return Event.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  static Future<void> addEvent(Map<String, dynamic> event) async {
    await FirebaseFirestore.instance.collection('events').add(event);
  }

  static Future<List<Event>> getEvents() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('events').get();
    return snapshot.docs.map((doc) {
      return Event.fromJson(doc.data() as Map<String, dynamic>);
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

  static Stream<Event> getEventById(String id) {
    return FirebaseFirestore.instance
        .collection('events')
        .doc(id)
        .snapshots()
        .map((doc) {
      return Event.fromJson(doc.data() as Map<String, dynamic>);
    });
  }

  static Future<void> addEventToUser(String email, Event event) async {
    final collection = FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .collection("events");
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

  static Future<void> updateUserEvent(String email, Event event) async {
    final collection = FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .collection("events");
    final doc = collection.doc(event.id);
    await doc.update(UserEventDetails(
      eventId: event.id,
      startTime: event.startTime,
      lastUpdated: event.lastUpdated,
    ).toJson());
  }
}
