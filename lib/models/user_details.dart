import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserDetails {
  final String id;
  final String name;
  final String title;
  final String designation;
  final String institution;
  final String email;
  final String billingAddress;
  final String foodPreference;
  final String registrationCategory;
  final String contact;
  final List<String> eventList;
  final String? fcmToken;

  const UserDetails({
    required this.id,
    required this.name,
    required this.title,
    required this.designation,
    required this.institution,
    required this.email,
    required this.billingAddress,
    required this.foodPreference,
    required this.registrationCategory,
    required this.contact,
    required this.eventList,
    this.fcmToken,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json, {String id = 'id'}) {
    //TODO: Implement, once response is jsonEncoded
    return UserDetails(
      id: json[id],
      name: "Name",
      title: json['title'],
      designation: json['designation'],
      institution: json['institution'],
      email: json['email'],
      billingAddress: json['billingAddress'],
      foodPreference: json['foodPreference'],
      registrationCategory: json['registrationCategory'],
      contact: json['contact'].toString(),
      eventList: (json['eventList'] as List? ?? []).map((e) => e.toString()).toList(),
      fcmToken: json['fcmToken'],
    );
  }

  Map<String, dynamic> toJson({bool eventList = false}) {
    final data = <String, dynamic>{
      'id': id,
      'name': name,
      'title': title,
      'designation': designation,
      'institution': institution,
      'billingAddress': billingAddress,
      'foodPreference': foodPreference,
      'registrationCategory': registrationCategory,
      'contact': contact,
      'email': email,
      'fcmToken': fcmToken,
    };

    if (eventList) {
      data['eventList'] = this.eventList;
    }
    return data;
  }

  Future<void> saveToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final userDetails = jsonEncode(toJson());
    prefs.setString('userDetails', userDetails);
  }

  static Future<UserDetails?> getFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final userDetails = prefs.getString('userDetails');
    if (userDetails == null) return null;
    final user = UserDetails.fromJson(jsonDecode(userDetails));
    return user;
  }

  UserDetails copyWith({
    String? id,
    String? name,
    String? title,
    String? designation,
    String? institution,
    String? email,
    String? billingAddress,
    String? foodPreference,
    String? registrationCategory,
    String? contact,
    List<String>? eventList,
    String? fcmToken,
  }) {
    return UserDetails(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      designation: designation ?? this.designation,
      institution: institution ?? this.institution,
      email: email ?? this.email,
      billingAddress: billingAddress ?? this.billingAddress,
      foodPreference: foodPreference ?? this.foodPreference,
      registrationCategory: registrationCategory ?? this.registrationCategory,
      contact: contact ?? this.contact,
      eventList: eventList ?? this.eventList,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }
}

class Name {
  final String first;
  final String middle;
  final String last;

  const Name({
    required this.first,
    required this.middle,
    required this.last,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      first: json['first'],
      middle: json['middle'],
      last: json['last'],
    );
  }

  String get fullName => first + (middle.isEmpty ? " " : middle) + last;
}
