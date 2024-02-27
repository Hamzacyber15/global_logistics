import 'package:cloud_firestore/cloud_firestore.dart';

class PublicProfileModel {
  String id;
  String firstName;
  String lastName;
  String url;
  String gender;
  String role;
  String status;
  PublicProfileModel(
    this.id,
    this.firstName,
    this.lastName,
    this.url,
    this.gender,
    this.role,
    this.status,
  );
  factory PublicProfileModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return PublicProfileModel(
      doc.id,
      data['firstName'] ?? "",
      data['lastName'] ?? "",
      data['profileUrl'] ?? "",
      data['gender'] ?? "",
      data['role'] ?? "",
      data['status'] ?? "",
    );
  }

  static Future<PublicProfileModel?> getPublicProfile(String id) async {
    try {
      return FirebaseFirestore.instance
          .collection('profile')
          .doc(id)
          .get()
          .then((value) {
        if (value.exists) {
          return PublicProfileModel.fromFirestore(value);
        } else {
          return null;
        }
      });
    } catch (e) {
      return null;
    }
  }
}
