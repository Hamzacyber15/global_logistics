import 'package:cloud_firestore/cloud_firestore.dart';

class PublicProfileModel {
  String id;
  String businessEmail;
  String? businessId;
  Timestamp timestamp;
  String userEmail;
  String role;
  String status;

  PublicProfileModel(
    this.id,
    this.businessEmail,
    this.timestamp,
    this.userEmail,
    this.role,
    this.status, {
    this.businessId,
  });
  factory PublicProfileModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return PublicProfileModel(
      doc.id,
      data['businessEmail'] ?? "",
      data['timestamp'] ?? Timestamp.now(),
      data['userEmail'] ?? "",
      data['userRole'] ?? "",
      data['status'] ?? "",
      businessId: data['businessId'] ?? "",
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
