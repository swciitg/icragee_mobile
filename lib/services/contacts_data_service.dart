import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/emergency_contact.dart';

class ContactsDataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<EmergencyContact>> fetchContactsByCategory(
      String category) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
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
}
