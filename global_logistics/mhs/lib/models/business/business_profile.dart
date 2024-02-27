import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mhs/models/business/business_area_model.dart';

class BusinessProfileModel {
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
  BusinessProfileModel({
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
  factory BusinessProfileModel.fromMap(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    BusinessProfileModel bp = BusinessProfileModel(
        id: "",
        businessAddress: "",
        businessAreas: [],
        certificate: [],
        nameArabic: "",
        nameEnglish: "",
        phoneNumber: "",
        registrationNum: "",
        status: "",
        userCountry: "",
        userEmail: "",
        userId: "",
        userLanguage: "",
        userMobile: "",
        userName: "",
        userAttachment: []);
    List<dynamic> bArea = data!['businessAreas'] ?? [];
    List<BusinessAreaModel> bm = [];
    for (var element in bArea) {
      bm.add(BusinessAreaModel(
          title: element['title'] ?? "", value: element['value'] ?? ""));
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
    bp = BusinessProfileModel(
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
    return bp;
  }
  static BusinessProfileModel? getBusinessList(
      DocumentSnapshot<Map<String, dynamic>> d) {
    try {
      return BusinessProfileModel.fromMap(d);
    } catch (e) {
      return null;
    }
  }
}
