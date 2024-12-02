import 'package:cloud_firestore/cloud_firestore.dart';

class CoordinateModel {
  final String title;
  final GeoPoint coordinate;

  CoordinateModel({
    required this.title,
    required this.coordinate,
  });

  factory CoordinateModel.fromMap(Map<String, dynamic> map) {
    return CoordinateModel(
      title: map['title'],
      coordinate: map['coordinate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'coordinate': coordinate,
    };
  }
}
