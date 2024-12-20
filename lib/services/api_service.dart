import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:icragee_mobile/models/user_details.dart';
import 'package:image_picker/image_picker.dart';

class ApiService {
  static const baseUrl = "https://event.iitg.ac.in/8icragee/api";
  static final dio = Dio(BaseOptions(baseUrl: baseUrl));

  static Future<String> uploadImage(XFile? image) async {
    Map<String, dynamic> mp = {};
    if (image != null) {
      String fileName = image.path.split('/').last;
      mp['image'] = await MultipartFile.fromFile(
        image.path,
        filename: fileName,
        contentType: MediaType('image', 'png'),
      );
    }
    FormData formData = FormData.fromMap(mp);

    final res = await dio.post('/user/uploadimage', data: formData);
    return res.data['imageUrl'] ?? '';
  }

  static Future<void> sendOTP(String email, {bool admin = false}) async {
    try {
      debugPrint("Sending OTP to (${admin ? "admin" : "user"}): $email");
      await dio.post('/${admin ? "newadmin" : "user"}/send-otp', data: {'email': email});
    } on DioException catch (e) {
      final data = e.response?.data as Map<String, dynamic>?;
      final message = data?['message'] as String?;
      if (message != null && message.contains('Admin not found')) {
        throw Exception("No admin found with this email");
      }
    }
  }

  static Future<bool> verifyOTP(String email, String otp, {bool admin = false}) async {
    // admin endpoint: /newadmin/verify-otp
    try {
      debugPrint("Verify OTP (${admin ? "admin" : "user"}): $email");
      final res = await dio.post('/${admin ? "newadmin" : "user"}/verify-otp', data: {
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

  static Future<void> sendInstantTopicNotification({
    required String topic,
    required String title,
    required String body,
  }) async {
    try {
      await dio.post('/notification/sendTopic', data: {
        'topic': topic,
        'title': title,
        'body': body,
      });
    } catch (e) {
      debugPrint("Error scheduling event: $e");
      rethrow;
    }
  }

  static Future<void> scheduleTopicNotification({
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
