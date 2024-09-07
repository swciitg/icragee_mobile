import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icragee_mobile/models/emergency_contact.dart';
import 'package:icragee_mobile/models/event.dart';
import 'package:icragee_mobile/models/faq.dart';

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
      return Event.fromJson(
          {...(doc.data() as Map<String, dynamic>), 'id': doc.id});
    }).toList();
  }

  static Future<void> addEvent(Map<String, dynamic> event) async {
    await FirebaseFirestore.instance.collection('events').add(event);
  }

  static Future<List<Event>> getEvents() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('events').get();
    return snapshot.docs.map((doc) {
      print(doc.data());
      return Event.fromJson(
          {...(doc.data() as Map<String, dynamic>), 'id': doc.id});
    }).toList();
  }

  // static Stream<List<UserDetails>> getUserEventIds(String email) {
  //   return FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(email)
  //       .collection("events")
  //       .orderBy('startTime')
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       return UserDetails.fromJson(doc.data());
  //     }).toList();
  //   });
  // }

  static Stream<Event> getEventById(String id) {
    return FirebaseFirestore.instance
        .collection('events')
        .doc(id)
        .snapshots()
        .map((doc) {
      return Event.fromJson(doc.data() as Map<String, dynamic>);
    });
  }

  static Future<List<String>> getUserEventIds(String email) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('userDetails')
        .where('email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final userDoc = querySnapshot.docs.first;
      List<String> eventList =
          List<String>.from(userDoc.data()['eventList'] ?? []);
      return eventList;
    } else {
      throw Exception('User not found!');
    }
  }

  // TODO: Email should come from Shared Prefs after Authentication is integrated
  static Future<void> addEventToUser(String email, String eventId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('userDetails')
        .where('email', isEqualTo: email)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      final userDoc = querySnapshot.docs.first;
      await userDoc.reference.update({
        'eventList': FieldValue.arrayUnion([eventId])
      });
    } else {
      throw Exception('User not found!');
    }
  }

// static getUserEventIds(String s) {}

// static Future<void> updateUserEvent(String email, Event event) async {
//   final collection = FirebaseFirestore.instance
//       .collection('users')
//       .doc(email)
//       .collection("events");
//   final doc = collection.doc(event.id);
//   await doc.update(UserDetails(
//     eventId: event.id,
//     startTime: event.startTime,
//     lastUpdated: event.lastUpdated,
//   ).toJson());
// }
}
