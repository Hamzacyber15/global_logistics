import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/models/attachment_model.dart';
import 'package:mhs/models/business/business_profile.dart';
import 'package:mhs/models/business_profile_model_profile.dart';
import 'package:mhs/models/drop_down_menu_model.dart';
import 'package:mhs/models/publicprofilemodel.dart';

class Constants {
  static String businessId = "";
  static String profileId = "";
  static bool bigScreen = false;
  static DropDownMenuDataModel a = DropDownMenuDataModel("", "A-1", "A-1");
  static DropDownMenuDataModel d = DropDownMenuDataModel("", "A-1", "A-1");
  static DropDownMenuDataModel o = DropDownMenuDataModel("", "A-1", "A-1");
  static DropDownMenuDataModel p = DropDownMenuDataModel("", "A-1", "A-1");
  static List<DropDownMenuDataModel> countries = [
    DropDownMenuDataModel("", "Oman", "country"),
    DropDownMenuDataModel("", "United Arab Emirates", "country"),
    DropDownMenuDataModel("", "Lebanon", "country"),
    DropDownMenuDataModel("", "Bahrain", "country"),
    DropDownMenuDataModel("", "India", "country"),
    DropDownMenuDataModel("", "Pakistan", "country"),
    DropDownMenuDataModel("", "Bangladesh", "country"),
    DropDownMenuDataModel("", "Egypt", "country"),
  ];

  static List<DropDownMenuDataModel> indoorEquipmentType = [
    DropDownMenuDataModel("", "Electric ForkLift", "Electric Forklift",
        image: "assets/images/electric_forklift.png"),
    DropDownMenuDataModel(
      "",
      "Ride On ForkLift",
      "Ride On ForkLift",
      image: "assets/images/rideon_forklift.png",
    )
  ];
  static List<DropDownMenuDataModel> outDoorEquipmentType = [
    DropDownMenuDataModel(
        "", '4 Wheel Diesel Forklift', '4 Wheel Diesel Forklift',
        image: "assets/images/4wheel_diesel_forklift.png"),
    DropDownMenuDataModel(
      "",
      "Tuk Tuk Electric",
      "Tuk Tuk Electric",
      image: "assets/images/electric_tuk-tuk.png",
    ),
    DropDownMenuDataModel(
      "",
      "Tractor",
      "Tractor",
      image: "assets/images/tractor.png",
    ),
    DropDownMenuDataModel("", "10-Ton Reefer Truck", "10-Ton Reefer Truck",
        image: "assets/images/reefer_truck.png")
  ];

  static List<DropDownMenuDataModel> employeeCategory = [
    DropDownMenuDataModel("", "Operation Supervisor", "operation supervisor"),
    DropDownMenuDataModel("", "TukTuk Driver", "tuktuk driver"),
    DropDownMenuDataModel("", "Forklift Driver", "forklift driver"),
    DropDownMenuDataModel("", "Labour", "labour"),
  ];

  static List<DropDownMenuDataModel> businessArea = [
    DropDownMenuDataModel("", "Whole Sale Area", "whole sale area"),
    DropDownMenuDataModel("", "Cold Storage Area", "cold storage area"),
    DropDownMenuDataModel("", "Onion Area", "onion area"),
    DropDownMenuDataModel("", "Potato Area", "potato area"),
    DropDownMenuDataModel(
        "", "Sell from the truck Area", "sell from thr truck area"),
  ];

  static List<DropDownMenuDataModel> coldStorageBlock = [
    DropDownMenuDataModel("", "D", "d"),
    DropDownMenuDataModel("", "E", "e"),
    DropDownMenuDataModel("", "F", "f"),
  ];

  static List<DropDownMenuDataModel> equipmentType = [
    DropDownMenuDataModel("", "Electric TukTuk", "electric tuk tuk"),
    DropDownMenuDataModel(
        "", "Electric Ride-On Forklift", "electric ride-on forklift"),
    DropDownMenuDataModel(
        "", "Electric 3 Wheel Forklift", "electric 3wheel forklift"),
    DropDownMenuDataModel(
        "", "Diesel 4 Wheel Forklift", "diesel 4 wheel forklift"),
  ];

  static List<DropDownMenuDataModel> languageList = [
    DropDownMenuDataModel("", "Arabic", "arabic"),
    DropDownMenuDataModel("", "English", "english"),
    DropDownMenuDataModel("", "Malyalam", "malyalam"),
    DropDownMenuDataModel("", "Bangali", "bangali"),
    DropDownMenuDataModel("", "Urdu", "urdu"),
  ];

  static BusinessProfileModelProfile businessProfile =
      BusinessProfileModelProfile(
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
  static PublicProfileModel profile =
      PublicProfileModel("", "", Timestamp.now(), "", "", "");

  static Future<String> uploadAttachment(AttachmentModel attachment) async {
    String url = '';
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return url;
    }
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    String fileName = timestamp.toString() + user.uid;
    final ref =
        FirebaseStorage.instance.ref().child('attachments').child(fileName);
    UploadTask? uploadTask;
    if (attachment.file != null) {
      uploadTask = ref.putFile(attachment.file!);
    } else if (attachment.attachmentType.isNotEmpty) {
      uploadTask = ref.putFile(attachment.file!);
      // String url = await (await uploadTask).ref.getDownloadURL();
      // uploadTask = ref.putData(attachment.file!);
    } else if (attachment.bytes != null) {
      uploadTask = ref.putData(attachment.bytes!);
    }
    url = await (await uploadTask!).ref.getDownloadURL();
    return url;
  }

  static void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  static String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return '${text[0].toUpperCase()}${text.substring(1)}';
  }

  // static String timestampToString(Timestamp dt) {
  //   DateTime t = dt.toDate();
  //   var formatter = intl.DateFormat('hh.mm a, dd MMM, yy');
  //   return formatter.format(t);
  // }
}
