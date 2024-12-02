import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/user_details.dart';
import 'package:icragee_mobile/widgets/snackbar.dart';
import 'package:image_picker/image_picker.dart';

class ApiService {
  static const baseUrl = "https://event.iitg.ac.in/8icragee/api";
  static final dio = Dio(BaseOptions(baseUrl: baseUrl));

  static Future<void> sendOTP(String email, {bool admin = false}) async {
    // admin endpoint: /newadmin/send-otp
    // Error if user is not admin 'Admin not found' in message
    try {
      debugPrint("Sending OTP to (${admin ? "admin" : "user"}): $email");
      await dio.post('/${admin ? "newadmin" : "user"}/send-otp', data: {'email': email});
    } on DioException catch (e) {
      final data = e.response?.data as Map<String, dynamic>?;
      final message = data?['message'] as String?;
      if (message != null && message.contains('Admin not found')) {
        showSnackBar("No admin found with this email");
        return;
      }
      rethrow;
    } catch (e) {
      debugPrint("Error sending otp: $e");
      rethrow;
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

  static Future<String?> uploadImage(XFile file) async {
    try {
      final name = file.path.split('/').last;
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: name),
      });
      final res = await dio.post('user/uploadimage', data: formData);
      print("image url data");
      print(res.data);
      return res.data['url'] as String?;
    } catch (e) {
      debugPrint("Error uploading image: $e");
      rethrow;
    }
  }
}
