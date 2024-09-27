import 'package:flutter/material.dart';
import 'package:icragee_mobile/models/user_details.dart';

class UserProvider extends ChangeNotifier {
  UserDetails? _userDetails;
  UserDetails? get userDetails => _userDetails;

  void setUserDetails(UserDetails? userDetails) {
    _userDetails = userDetails;
    notifyListeners();
  }

  void setUserEventList(List<String> eventList) {
    if (_userDetails == null) {
      debugPrint("User details is NULL");
      return;
    }
    _userDetails = _userDetails!.copyWith(eventList: eventList);
    notifyListeners();
  }
}
