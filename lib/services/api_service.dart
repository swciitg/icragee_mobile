import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/user_details.dart';

class ApiService {
  static const baseUrl = "https://event.iitg.ac.in/8icragee/api";
  final dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> sendOTP(String email) async {
    // TODO: newadmin instead user for admin login
    // Error 'Admin not found' in message
    try {
      await dio.post('/user/send-otp', data: {'email': email});
    } catch (e) {
      debugPrint("Error sending otp: $e");
      rethrow;
    }
  }

  Future<bool> verifyOTP(String email, String otp) async {
    try {
      final res = await dio.post('/user/verify-otp', data: {
        'email': email,
        'otp': int.parse(otp),
      });
      final data = res.data as Map<String, dynamic>;
      final user = data['user'] as Map<String, dynamic>?;
      final message = data['message'] as String;
      if (user != null) {
        user['fcmToken'] = await FirebaseMessaging.instance.getToken();
        final userDetails = UserDetails.fromJson(user, id: "_id");
        await userDetails.saveToSharedPreferences();
      }
      return message.contains("Verified") && user != null;
    } catch (e) {
      debugPrint("Error verifying otp: $e");
      rethrow;
    }
  }

  Future<void> scheduleTopicNotification({
    required String topic,
    required DateTime time,
    required String title,
    required String body,
  }) async {
    try {
      await dio.post('/notification/createEvent', data: {
        'topic': topic,
        'time': time.toUtc().toString(),
        'title': title,
        'body': body,
      });
    } catch (e) {
      debugPrint("Error scheduling event: $e");
      rethrow;
    }
  }
}
