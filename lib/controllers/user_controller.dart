import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icragee_mobile/models/user_details.dart';

import '../services/data_service.dart';

final userProvider = StateNotifierProvider<UserProvider, UserDetails?>((ref) {
  return UserProvider();
});

class UserProvider extends StateNotifier<UserDetails?> {
  UserProvider() : super(null);

  var adminAuth = false;

  void setAdminAuth(bool value) {
    debugPrint("Admin auth: $value");
    adminAuth = value;
  }

  void setUserDetails(UserDetails? userDetails) {
    state = userDetails;
    if (state != null) {
      state!.saveToSharedPreferences();
    }
  }

  void setUserEventList(List<String> eventList) {
    if (state == null) {
      debugPrint("User details is NULL");
      return;
    }
    state = state!.copyWith(eventList: eventList);
  }

  void updateIfSuperUser() async {
    // if (state == null) {
    //   debugPrint("User details is NULL");
    //   return;
    // }
    // final isSuperUser = await DataService.isSuperUser(state!.email);
    // state = state!.copyWith(role: isSuperUser);
  }

  Future<void> updateUserDetails() async {
    if (state == null) return;
    final user = await DataService.getUserDetailsById(state!.id);
    if (user == null) return;
    state = user;
  }
}
