import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/models/attachment_model.dart';
import 'package:mhs/models/drop_down_menu_model.dart';

class Constants {
  static bool bigScreen = false;
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

  static List<DropDownMenuDataModel> employeeCategory = [
    DropDownMenuDataModel("", "Operation Supervisor", "operation supervisor"),
    DropDownMenuDataModel("", "TukTuk Driver", "tuktuk driver"),
    DropDownMenuDataModel("", "Forklift Driver", "forklift driver"),
    DropDownMenuDataModel("", "Labour", "labour"),
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
