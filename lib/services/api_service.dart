import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiService {
  static const baseUrl = "https://event.iitg.ac.in/8icragee/api";
  final dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<String> sendOTP(String email) async {
    try {
      print("sending otp");
      final res = await dio.post('/user/send-otp', data: {
        'email': email,
      });
      print("otp res: " + res.data);
      return "";
    } catch (e) {
      debugPrint("Error sending otp: $e");
      rethrow;
    }
  }
}
