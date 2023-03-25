import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class UserData {
  String id;
  final String? fName;
  final String? lName;
  final String? email;
  final String? city;

  UserData(
      {required this.id,
      required this.fName,
      required this.lName,
      required this.email,
      required this.city});

  Map<String, dynamic> toJson() =>
      {'id': id, 'fName': fName, 'lName': lName, 'email': email, 'city': city};

  static UserData fromJson(Map<String, dynamic> json) => UserData(
      id: json['id'] ?? '',
      fName: json['fName'] ?? '',
      lName: json['lName'] ?? '',
      email: json['email'] ?? '',
      city: json['city'] ?? '');

  factory UserData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserData(
        id: data?['id'],
        fName: data?['fName'],
        lName: data?['lName'],
        email: data?['email'],
        city: data?['city']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (fName != null) "fName": fName,
      if (lName != null) "lName": lName,
      if (email != null) "email": email,
      if (city != null) "city": city
    };
  }
}
