import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserDetails {
  final String email;
  final List<String> eventsList;
  final String fcmToken;

  const UserDetails({
    required this.email,
    required this.eventsList,
    required this.fcmToken,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      eventsList: json['eventsList'] ?? [],
      email: json['email'],
      fcmToken: json['fcmToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'eventsList': eventsList, 'email': email, 'fcmToken': fcmToken};
  }

  void saveToSharedPreferences() {
    final prefs = SharedPreferences.getInstance();
    final userDetails = jsonEncode(toJson());
    prefs.then((value) => value.setString('userDetails', userDetails));
  }

  static Future<UserDetails?> getFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final userDetails = prefs.getString('userDetails');
    if (userDetails == null) return null;
    return UserDetails.fromJson(jsonDecode(userDetails));
  }
}
