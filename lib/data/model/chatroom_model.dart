import 'package:cloud_firestore/cloud_firestore.dart';

class ChatroomModel {
  final String id;
  final String location;
  final int members;
  final double rating;
  final GeoPoint geopoint;

  ChatroomModel({
    required this.id,
    required this.location,
    required this.members,
    required this.rating,
    required this.geopoint,
  });

  factory ChatroomModel.fromJson(Map<String, dynamic> json) {
    return ChatroomModel(
      id: json['id'] as String,
      location: json['location'] as String,
      members: json['members'] as int,
      rating: (json['rating'] as num).toDouble(),
      geopoint: json['geopoint'] as GeoPoint,
    );
  }
}
