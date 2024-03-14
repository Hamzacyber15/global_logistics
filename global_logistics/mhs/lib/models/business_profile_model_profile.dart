import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mhs/models/business/business_area_model.dart';

class BusinessProfileModelProfile {
  String id;
  String businessAddress;
  List<BusinessAreaModel> businessAreas;
  List<String> certificate;
  String nameArabic;
  String nameEnglish;
  String phoneNumber;
  String registrationNum;
  String status;
  String userCountry;
  String userEmail;
  String userId;
  String userLanguage;
  String userMobile;
  String userName;
  List<String> userAttachment;
  BusinessProfileModelProfile({
    required this.id,
    required this.businessAddress,
    required this.businessAreas,
    required this.certificate,
    required this.nameArabic,
    required this.nameEnglish,
    required this.phoneNumber,
    required this.registrationNum,
    required this.status,
    required this.userCountry,
    required this.userEmail,
    required this.userId,
    required this.userLanguage,
    required this.userMobile,
    required this.userName,
    required this.userAttachment,
  });

  factory BusinessProfileModelProfile.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    List<dynamic> bArea = data!['businessAreas'] ?? [];
    List<BusinessAreaModel> bm = [];
    for (var element in bArea) {
      bm.add(BusinessAreaModel(
          id: element['id'] ?? "",
          title: element['storage'] ?? "",
          value: element['title'] ?? ""));
    }
    List<dynamic> certificate = data['certificate'] ?? [];
    List<String> c = [];
    for (var element in certificate) {
      c.add(element);
    }
    List<dynamic> attachment = data['userAttachment'] ?? [];
    List<String> a = [];
    for (var element in attachment) {
      a.add(element);
    }
    return BusinessProfileModelProfile(
        id: doc.id,
        businessAddress: data['businessAddress'] ?? "",
        businessAreas: bm,
        certificate: c,
        nameArabic: data['nameArabic'] ?? "",
        nameEnglish: data['nameEnglish'] ?? "",
        phoneNumber: data['phoneNumber'] ?? "",
        registrationNum: data['registrationNum'] ?? "",
        status: data['status'] ?? "",
        userCountry: data['userCountry'] ?? "",
        userEmail: data['userEmail'] ?? "",
        userId: data['userId'] ?? "",
        userLanguage: data['userLanguage'] ?? "",
        userMobile: data['userMobile'] ?? "",
        userName: data['userName'] ?? "",
        userAttachment: a);
  }

  static Future<BusinessProfileModelProfile?> getPublicProfile(
      String id) async {
    try {
      return FirebaseFirestore.instance
          .collection('business')
          .doc(id)
          .get()
          .then((value) {
        if (value.exists) {
          return BusinessProfileModelProfile.fromFirestore(value);
        } else {
          return null;
        }
      });
    } catch (e) {
      return null;
    }
  }
}
