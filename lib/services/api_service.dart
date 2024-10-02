import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiService {
  static const baseUrl = "https://event.iitg.ac.in/8icragee/api";
  final dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> sendOTP(String email) async {
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
      final message = data['message'] as String;
      return message.contains('verified');
    } catch (e) {
      debugPrint("Error verifying otp: $e");
      rethrow;
    }
  }
}
