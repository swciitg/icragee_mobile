import 'package:cloud_firestore/cloud_firestore.dart';

class CoordinateModel {
  final String title;
  final String id;
  final GeoPoint coordinate;

  CoordinateModel({
    required this.title,
    required this.id,
    required this.coordinate,
  });

  factory CoordinateModel.fromMap(Map<String, dynamic> map) {
    return CoordinateModel(
      id: map['id'],
      title: map['title'],
      coordinate: map['coordinate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'title': title,
      'coordinate': coordinate,
    };
  }
}
