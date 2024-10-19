import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icragee_mobile/models/user_details.dart';

final userProvider = StateNotifierProvider<UserProvider, UserDetails?>((ref) {
  return UserProvider();
});

class UserProvider extends StateNotifier<UserDetails?> {
  UserProvider() : super(null);

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
}
