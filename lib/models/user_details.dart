import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserDetails {
  final String id;
  final Name name;
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
  final bool inCampus;
  final List<MealAccess> mealAccess;
  final bool superUser;

  String get fullName => name.fullName;

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
    this.inCampus = false,
    this.mealAccess = const [],
    this.superUser = false,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json, {String id = 'id'}) {
    final name = Name.fromJson(json['name'] as Map<String, dynamic>);
    return UserDetails(
      id: json[id],
      name: name,
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
      inCampus: json['inCampus'] ?? false,
      mealAccess: (json['mealAccess'] as List? ?? []).map((e) => MealAccess.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson({bool eventList = false}) {
    final data = {
      'id': id,
      'name': name.toJson(),
      'title': title,
      'designation': designation,
      'institution': institution,
      'billingAddress': billingAddress,
      'foodPreference': foodPreference,
      'registrationCategory': registrationCategory,
      'contact': contact,
      'email': email,
      'fcmToken': fcmToken,
      'inCampus': inCampus,
      'mealAccess': mealAccess.map((e) => e.toJson()).toList(),
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
    Name? name,
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
    bool? inCampus,
    List<MealAccess>? mealAccess,
    bool? superUser,
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
      inCampus: inCampus ?? this.inCampus,
      mealAccess: mealAccess ?? this.mealAccess,
      superUser: superUser ?? this.superUser,
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
      first: json['first'].toString(),
      middle: json['middle'].toString(),
      last: json['last'].toString(),
    );
  }

  String get fullName => "$first ${middle.isEmpty ? "" : "$middle "}$last";

  Map<String, dynamic> toJson() {
    return {
      'first': first,
      'middle': middle,
      'last': last,
    };
  }
}

class MealAccess {
  final int day;
  final String mealType;
  final bool taken;

  const MealAccess({
    required this.day,
    required this.mealType,
    required this.taken,
  });

  factory MealAccess.fromJson(Map<String, dynamic> json) {
    return MealAccess(
      day: json['day'],
      mealType: json['mealType'],
      taken: json['taken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'mealType': mealType,
      'taken': taken,
    };
  }
}
