import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

var dayOneDate = DateTime(2024, 12, 11);

final dates = ['Day 1', 'Day 2', 'Day 3', 'Day 4'];
final venues = [
  'NA',
  'Dr. Bhupen Hazarika Auditorium',
  'Mini Auditorium',
  'Conference Hall 1',
  'Conference Hall 2',
  'Conference Hall 3',
  'Conference Hall 4',
];
