import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

// TODO: FETCH THIS WHEN THE APP STARTS UP FROM THE BACKEND
final dayOneDate =
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
