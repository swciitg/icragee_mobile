import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event_model.dart';


class FirestoreService {
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
}
