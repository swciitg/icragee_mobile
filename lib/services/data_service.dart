import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icragee_mobile/models/contact_model.dart';
import 'package:icragee_mobile/models/coordinate_model.dart';
import 'package:icragee_mobile/models/event.dart';
import 'package:icragee_mobile/models/faq.dart';
import 'package:icragee_mobile/models/lost_found_model.dart';
import 'package:icragee_mobile/models/notification_model.dart';
import 'package:icragee_mobile/models/user_details.dart';
import 'package:icragee_mobile/shared/globals.dart';
import 'package:icragee_mobile/utility/functions.dart';

class DataService {
  static final firestore = FirebaseFirestore.instance;

  // Method to fetch FAQs from Firestore
  static Future<List<FaqContent>> fetchFaqs() async {
    final collectionSnapshot = await firestore.collection('FAQs').get();

    return collectionSnapshot.docs.map((doc) => FaqContent.fromJson(doc.data())).toList();
  }

  // Method to fetch emergency contacts by category from Firestore
  static Future<List<ContactModel>> fetchImportantContacts() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection('important_contacts').get();

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
      await firestore.collection("feedback").add({
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
        await firestore.collection('events').where('day', isEqualTo: day).get();
    final docs = querySnapshot.docs.map((doc) {
      final event = Event.fromJson({...(doc.data() as Map<String, dynamic>), 'id': doc.id});
      return event.copyWith(
          startTime: getActualEventTime(event.startTime, event.day),
          endTime: getActualEventTime(event.endTime, event.day));
    }).toList();
    docs.sort((a, b) {
      int timeComparison = a.startTime.compareTo(b.startTime);
      if (timeComparison != 0) {
        return timeComparison;
      } else {
        int titleComparison = a.title.compareTo(b.title);
        if (titleComparison != 0) {
          return titleComparison;
        } else {
          return a.venue.compareTo(b.venue);
        }
      }
    });
    return docs;
  }

  static Future<String?> addEvent(Event event) async {
    try {
      final collectionRef = firestore.collection('events');
      final doc = collectionRef.doc();
      event = event.copyWith(id: doc.id);
      await doc.set(event.toJson());
      return doc.id;
    } catch (e) {
      return null;
    }
  }

  static Future<void> editEvent(String eventId, Event updatedEvent) async {
    final collectionRef = firestore.collection('events');
    final doc = collectionRef.doc(eventId);

    await doc.update(updatedEvent.toJson());
  }

  static Future<List<Event>> getEvents() async {
    QuerySnapshot snapshot = await firestore.collection('events').get();
    return snapshot.docs.map((doc) {
      return Event.fromJson({...(doc.data() as Map<String, dynamic>), 'id': doc.id});
    }).toList();
  }

  static Stream<Event> getEventById(String id) {
    return firestore.collection('events').doc(id).snapshots().map((doc) {
      return Event.fromJson(doc.data() as Map<String, dynamic>);
    });
  }

  static Future<UserDetails?> getUserDetailsById(String id) async {
    final querySnapshot = await firestore.collection('userDetails').doc(id).get();

    if (!querySnapshot.exists) return null;
    return UserDetails.fromJson(querySnapshot.data()!);
  }

  static Future<List<String>> getUserEventIds(String id) async {
    final user = await firestore.collection('userDetails').doc(id).get();

    return List<String>.from(user['eventList'] ?? []);
  }

  static Stream<List<Event>> getUserEvents(List<String> eventIds) {
    return firestore
        .collection('events')
        .where(FieldPath.documentId, whereIn: eventIds)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Event.fromJson(data);
      }).toList();
    });
  }

  static Future<void> deleteEvent(String eventId) async {
    await firestore.collection('events').doc(eventId).delete();
  }

  static Future<void> addEventToUser(String id, String eventId) async {
    final doc = firestore.collection('userDetails').doc(id);
    await doc.update({
      'eventList': FieldValue.arrayUnion([eventId]),
    });
  }

  static Future<void> removeEventFromUser(String id, String eventId) async {
    final doc = firestore.collection('userDetails').doc(id);
    await doc.update({
      'eventList': FieldValue.arrayRemove([eventId]),
    });
  }

  static Future<void> postLostFoundData(LostFoundModel model) async {
    try {
      final newDoc = firestore.collection('lost_found_items').doc();
      model = model.copyWith(id: newDoc.id);
      await newDoc.set(model.toJson());
    } catch (error) {
      throw ('Failed to post ${model.category} item: $error');
    }
  }

  static Future<void> updateUserDetails(UserDetails user,
      {bool containsFirestoreData = true}) async {
    final userRef = firestore.collection('userDetails').doc(user.id);
    final doc = await userRef.get();
    if (doc.exists) {
      userRef.update(user.toJson(containsFirestoreData: containsFirestoreData));
    } else {
      if (user.mealAccess!.isEmpty) {
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
        user = user.copyWith(mealAccess: defaultMeals, inCampus: doc.data()?['inCampus'] ?? false);
      }
      userRef.set(user.toJson(containsFirestoreData: true));
    }
  }

  static Future<void> addNotification(NotificationModel notification) async {
    try {
      final doc = firestore.collection('notifications').doc(notification.id);
      await doc.set(notification.toJson());
    } catch (e) {
      throw Exception('Failed to add notification: $e');
    }
  }

  static Stream<List<NotificationModel>> getNotifications() {
    return firestore
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return NotificationModel.fromJson(doc.data());
      }).toList();
    });
  }

  static Future<void> deleteNotification(String id) async {
    await firestore.collection('notifications').doc(id).delete();
  }

  static Future<void> fetchDayOneDate() async {
    final doc = await firestore.collection('globals').doc('event').get();
    dayOneDate = DateTime.parse(doc.data()!['dayOneDate']);
  }

  static Future<void> markPresentInCampus(String id, bool value) async {
    final userRef = firestore.collection('userDetails').doc(id);
    final doc = await userRef.get();
    if (doc.exists) {
      userRef.update({'inCampus': value});
    }
  }

  static Stream<List<MealAccess>> getUserMealAccessSteam(String uid) {
    final ref = firestore.collection('userDetails').doc(uid);
    return ref.snapshots().map((doc) {
      final user = UserDetails.fromJson(doc.data()!);
      return user.mealAccess!;
    });
  }

  static Future<void> deleteLostFoundItem(String id) async {
    await firestore.collection('lost_found_items').doc(id).delete();
  }

  static Stream<List<String>> getMapSections() {
    final locationsRef = firestore.collection('locations');
    return locationsRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc['name'] as String;
      }).toList();
    });
  }

  static Future<void> addMapSection(String section) async {
    final ref = firestore.collection('locations');
    final doc = ref.doc(section);
    await doc.set({'name': section});
  }

  static Stream<List<CoordinateModel>> getMapSectionCoordinates(String section) {
    final ref = firestore.collection('locations').doc(section).collection('coordinates');
    return ref.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CoordinateModel.fromMap(doc.data());
      }).toList();
    });
  }

  static Future<void> addMapSectionCoordinate(String section, CoordinateModel coordinate) async {
    final ref =
        firestore.collection('locations').doc(section).collection('coordinates').doc(coordinate.id);
    await ref.set(coordinate.toMap());
  }

  static Future<void> updateMapSectionCoordinate(String section, CoordinateModel coordinate) async {
    final ref =
        firestore.collection('locations').doc(section).collection('coordinates').doc(coordinate.id);
    await ref.update(coordinate.toMap());
  }

  static Future<void> deleteMapSectionCoordinate(String section, String id) async {
    final ref = firestore.collection('locations').doc(section).collection('coordinates').doc(id);
    await ref.delete();
  }

  static Future<void> deleteMapSection(String section) async {
    final ref = firestore.collection('locations').doc(section);
    await ref.delete();
  }

  static Stream<int> registeredUsersCount() {
    return firestore
        .collection('userDetails')
        .where('inCampus', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.length;
    });
  }

  static Future<List<String>?> getEventVenues() async {
    final doc = await firestore.collection('globals').doc('event').get();
    if (!doc.exists) return null;
    return List<String>.from(doc.data()!['venues']);
  }

  static Stream<List<String>> getEventVenueStream() {
    return firestore.collection('globals').doc('event').snapshots().map((doc) {
      return List<String>.from(doc.data()!['venues']);
    });
  }

  // add event venue
  static Future<void> addEventVenue(String venue) async {
    final doc = firestore.collection('globals').doc('event');
    final data = await doc.get();
    final venues = List<String>.from(data.data()!['venues']);
    venues.add(venue);
    await doc.update({'venues': venues});
  }

  // delete event venue
  static Future<void> deleteEventVenue(String venue) async {
    final doc = firestore.collection('globals').doc('event');
    final data = await doc.get();
    final venues = List<String>.from(data.data()!['venues']);
    venues.remove(venue);
    await doc.update({'venues': venues});
  }

  static Future<void> addNewContact(ContactModel contact) async {
    try {
      await firestore.collection('important_contacts').add(contact.toJson());
    } catch (e) {
      throw Exception('Failed to add contact: $e');
    }
  }

  static Future<void> deleteContact(String number) async {
    final contactsRef = firestore.collection('important_contacts');
    final querySnapshot = await contactsRef.where('phone', isEqualTo: number).get();

    if (querySnapshot.docs.isNotEmpty) {
      final docId = querySnapshot.docs.first.id;
      await contactsRef.doc(docId).delete();
    }
  }

  static Future<List<String>?> getContactTypes() async {
    final doc = await firestore.collection('globals').doc('contact').get();
    if (!doc.exists) return null;
    return List<String>.from(doc.data()!['types']);
  }

  static Future<List<MealAccess>> getMealAcessofUsers() async {
    final querySnapshot = await firestore.collection('userDetails').get();
    List<MealAccess> mealAccess = [];
    querySnapshot.docs.map((doc) {
      final user = UserDetails.fromJson(doc.data());
      mealAccess.addAll(user.mealAccess!);
    }).toList();
    return mealAccess;
  }

  static Future<String?> getScheduleUrl() async {
    final doc = await firestore.collection('globals').doc('event').get();
    if (!doc.exists) return null;
    return doc.data()!['scheduleUrl'];
  }
}
