import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserDetails {
  final String email;
  final List<String> eventList;
  final String? fcmToken;

  const UserDetails({
    required this.email,
    required this.eventList,
    this.fcmToken,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      eventList: (json['eventList'] as List? ?? []).map((e) => e.toString()).toList(),
      email: json['email'],
      fcmToken: json['fcmToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'eventList': eventList, 'email': email, 'fcmToken': fcmToken};
  }

  Future<void> saveToSharedPreferences() async{
    final prefs = await SharedPreferences.getInstance();
    final userDetails = jsonEncode(toJson());
    prefs.setString('userDetails', userDetails);
  }

  static Future<UserDetails?> getFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final userDetails = prefs.getString('userDetails');
    if (userDetails == null) return null;
    return UserDetails.fromJson(jsonDecode(userDetails));
  }

  UserDetails copyWith({
    String? email,
    List<String>? eventList,
    String? fcmToken,
  }) {
    return UserDetails(
      email: email ?? this.email,
      eventList: eventList ?? this.eventList,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }
}
