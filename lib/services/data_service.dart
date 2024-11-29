import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icragee_mobile/models/contact_model.dart';
import 'package:icragee_mobile/models/event.dart';
import 'package:icragee_mobile/models/faq.dart';
import 'package:icragee_mobile/models/notification_model.dart';
import 'package:icragee_mobile/models/user_details.dart';
import 'package:icragee_mobile/shared/globals.dart';
import 'package:icragee_mobile/utility/functions.dart';
import 'package:image_picker/image_picker.dart';

class DataService {
  // Method to fetch FAQs from Firestore
  static Future<List<FaqContent>> fetchFaqs() async {
    final collectionSnapshot = await FirebaseFirestore.instance.collection('FAQs').get();

    return collectionSnapshot.docs.map((doc) => FaqContent.fromJson(doc.data())).toList();
  }

  // Method to fetch emergency contacts by category from Firestore
  static Future<List<ContactModel>> fetchImportantContacts() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('important_contacts').get();

      // Convert each document into a Contact object
      List<ContactModel> contacts = querySnapshot.docs.map((doc) {
        return ContactModel.fromJson(doc.data() as Map<String, dynamic>);
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
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('events').where('day', isEqualTo: day).get();
    final docs = querySnapshot.docs.map((doc) {
      final event = Event.fromJson({...(doc.data() as Map<String, dynamic>), 'id': doc.id});
      return event.copyWith(
          startTime: getActualEventTime(event.startTime, event.day),
          endTime: getActualEventTime(event.endTime, event.day));
    }).toList();
    docs.sort((a, b) {
      return a.startTime.compareTo(b.startTime);
    });
    return docs;
  }

  static Future<String?> addEvent(Event event) async {
    try {
      final collectionRef = FirebaseFirestore.instance.collection('events');
      final doc = collectionRef.doc();
      event = event.copyWith(id: doc.id);
      await doc.set(event.toJson());
      return doc.id;
    } catch (e) {
      return null;
    }
  }

  static Future<void> editEvent(String eventId, Event updatedEvent) async {
    final collectionRef = FirebaseFirestore.instance.collection('events');
    final doc = collectionRef.doc(eventId);

    await doc.update(updatedEvent.toJson());
  }

  static Future<List<Event>> getEvents() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('events').get();
    return snapshot.docs.map((doc) {
      return Event.fromJson({...(doc.data() as Map<String, dynamic>), 'id': doc.id});
    }).toList();
  }

  static Stream<Event> getEventById(String id) {
    return FirebaseFirestore.instance.collection('events').doc(id).snapshots().map((doc) {
      return Event.fromJson(doc.data() as Map<String, dynamic>);
    });
  }

  static Future<UserDetails?> getUserDetailsByEmail(String email) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('userDetails')
        .where('email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final userDoc = querySnapshot.docs.first;
      return UserDetails.fromJson(userDoc.data());
    } else {
      return null;
    }
  }

  static Future<UserDetails?> getUserDetailsById(String id) async {
    final querySnapshot = await FirebaseFirestore.instance.collection('userDetails').doc(id).get();

    if (!querySnapshot.exists) return null;
    return UserDetails.fromJson(querySnapshot.data()!);
  }

  static Future<List<String>> getUserEventIds(String email) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('userDetails')
        .where('email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final userDoc = querySnapshot.docs.first;
      List<String> eventList = List<String>.from(userDoc.data()['eventList'] ?? []);
      return eventList;
    } else {
      throw Exception('User not found!');
    }
  }

  static Stream<List<Event>> getUserEvents(List<String> eventIds) {
    return FirebaseFirestore.instance
        .collection('events')
        .where(FieldPath.documentId, whereIn: eventIds)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Event.fromJson(doc.data());
      }).toList();
    });
  }

  static Future<void> deleteEvent(String eventId) async {
    await FirebaseFirestore.instance.collection('events').doc(eventId).delete();
  }

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

  static Future<void> postLostFoundData({
    required String category,
    required String title,
    required String description,
    required String location,
    required String contact,
    required XFile image,
    required String name,
    required String email,
  }) async {
    try {
      // Choose the collection based on the category (Lost or Found)
      String collectionName = category == "Lost" ? "lost_items" : "found_items";

      await FirebaseFirestore.instance.collection(collectionName).add({
        "title": title,
        "description": description,
        "location": location,
        "contact": contact,
        "image": image.path,
        "email": email,
        "name": name,
        "submittedAt": FieldValue.serverTimestamp(),
      });
    } catch (error) {
      throw ('Failed to post $category item: $error');
    }
  }

  static Future<void> updateUserDetails(UserDetails user) async {
    final userRef = FirebaseFirestore.instance.collection('userDetails').doc(user.id);
    final doc = await userRef.get();
    if (doc.exists) {
      userRef.update(user.toJson());
    } else {
      if (user.mealAccess.isEmpty) {
        final defaultMeals = [
          // Day 1
          MealAccess(day: 1, mealType: "Breakfast", taken: false),
          MealAccess(day: 1, mealType: "Lunch", taken: false),
          MealAccess(day: 1, mealType: "Dinner", taken: false),
          // Day 2
          MealAccess(day: 2, mealType: "Breakfast", taken: false),
          MealAccess(day: 2, mealType: "Lunch", taken: false),
          MealAccess(day: 2, mealType: "Dinner", taken: false),
          // Day 3
          MealAccess(day: 3, mealType: "Breakfast", taken: false),
          MealAccess(day: 3, mealType: "Lunch", taken: false),
          MealAccess(day: 3, mealType: "Dinner", taken: false),
          // Day 4
          MealAccess(day: 4, mealType: "Breakfast", taken: false),
          MealAccess(day: 4, mealType: "Lunch", taken: false),
          MealAccess(day: 4, mealType: "Dinner", taken: false),
        ];
        user = user.copyWith(mealAccess: defaultMeals, inCampus: doc.data()!['inCampus'] ?? false);
      }
      userRef.set(user.toJson(eventList: true));
    }
  }

  static Future<void> addNotification(NotificationModel notification) async {
    try {
      await FirebaseFirestore.instance.collection('notifications').add(notification.toJson());
    } catch (e) {
      throw Exception('Failed to add notification: $e');
    }
  }

  static Stream<List<NotificationModel>> getNotifications() {
    return FirebaseFirestore.instance
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return NotificationModel.fromJson(doc.data());
      }).toList();
    });
  }

  static Future<bool> isSuperUser(String email) async {
    final doc = await FirebaseFirestore.instance.collection('globals').doc('superUsers').get();
    final superUsers = List<String>.from(doc.data()!['emails'] ?? []);

    return superUsers.contains(email);
  }

  static Future<void> fetchDayOneDate() async {
    final doc = await FirebaseFirestore.instance.collection('globals').doc('event').get();
    dayOneDate = DateTime.parse(doc.data()!['dayOneDate']);
  }

  static Future<void> markPresentInCampus(String id) async {
    final userRef = FirebaseFirestore.instance.collection('userDetails').doc(id);
    final doc = await userRef.get();
    if (doc.exists) {
      userRef.update({'inCampus': true});
    }
  }
}
