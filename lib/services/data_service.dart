import 'package:cloud_firestore/cloud_firestore.dart';

class DataService {
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
}
