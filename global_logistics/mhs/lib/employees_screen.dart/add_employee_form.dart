import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/constants.dart';
import 'package:mhs/models/attachment_model.dart';
import 'package:mhs/models/drop_down_menu_model.dart';
import 'package:mhs/widgets/drop_down_menu.dart';
import 'package:mhs/widgets/picker_widget.dart';

import '../widgets/check_box_container.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  TextEditingController employeeName = TextEditingController();
  TextEditingController idCardNumber = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController otherCompanyName = TextEditingController();
  DropDownMenuDataModel employee = Constants.employeeCategory[0];
  String selectedDesignation = "";
  List<AttachmentModel> attachments = [];
  bool globalEmployee = false;
  bool loading = false;

  @override
  void dispose() {
    employeeName.dispose();
    idCardNumber.dispose();
    mobileNumber.dispose();
    otherCompanyName.dispose();
    super.dispose();
  }

  void message(String title) {
    Constants.showMessage(context, title);
  }

  void addEmployee() async {
    if (loading) {
      return;
    }
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    List<String> urls = [];
    // for (AttachmentModel attachment in attachments) {
    //   String url = await Constants.uploadAttachment(attachment);
    //   urls.add(url);
    // }
    // if (urls.isEmpty) {
    //   message("Please attach Front & Back Side of the id card");
    //   return;
    // }
    bool check = checkCredentials();
    if (!check) {
      return;
    }
    setState(() {
      loading = true;
    });
    try {
      String userId =
          FirebaseFirestore.instance.collection('employees').doc().id;
      await FirebaseFirestore.instance.collection('employees').doc(userId).set({
        'userId': userId,
        'name': employeeName.text.trim(),
        'designation': selectedDesignation,
        'idCardNumber': idCardNumber.text.trim(),
        'contactNumber': mobileNumber.text.trim(),
        'attachments': urls,
        'otherCompany': otherCompanyName.text.trim(),
        'globalEmployee': globalEmployee,
        'status': "active",
        'timestamp': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true)).then((value) {
        Constants.showMessage(context, "Employee Added");
        Navigator.of(context).pop();
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  bool checkCredentials() {
    bool result = false;
    if (employeeName.text.trim().isEmpty) {
      Constants.showMessage(context, "Employee Name is empty");
    } else if (selectedDesignation.isEmpty) {
      Constants.showMessage(context, "Please Select Designation");
    } else if (idCardNumber.text.trim().isEmpty) {
      Constants.showMessage(context, "Id Card Number is empty");
    } else if (mobileNumber.text.trim().isEmpty) {
      Constants.showMessage(context, "Mobile Number is Empty");
    } else if (!globalEmployee) {
      if (otherCompanyName.text.trim().isEmpty) {
        Constants.showMessage(context, "Please Enter Other Company Name");
      } else {
        result = true;
      }
    } else {
      result = true;
    }
    return result;
  }

  void getValues(String type, String value, String id) {
    selectedDesignation = value;
  }

  void onFilesPicked(List<AttachmentModel> files) {
    setState(() {
      attachments = files;
    });
  }

  void changeStatus() {
    globalEmployee = !globalEmployee;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Add Employee",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Card(
              color: AppTheme.primaryColor.withOpacity(0.1),
              child: TextField(
                controller: employeeName,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  labelText: "Name",
                ),
                cursorColor: AppTheme.primaryColor,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                },
              ),
            ),
            Card(
              color: AppTheme.primaryColor.withOpacity(0.1),
              child: DropDownMenu(
                  getValues,
                  "Designation",
                  //  const Icon(Icons.person),
                  Constants.employeeCategory,
                  employee,
                  "employee"),
            ),
            Card(
              color: AppTheme.primaryColor.withOpacity(0.1),
              child: TextField(
                controller: idCardNumber,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  labelText: "ID Card Number",
                ),
                cursorColor: AppTheme.primaryColor,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                },
              ),
            ),
            Card(
              color: AppTheme.primaryColor.withOpacity(0.1),
              child: TextField(
                controller: mobileNumber,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  labelText: "Contact Number",
                ),
                cursorColor: AppTheme.primaryColor,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                },
              ),
            ),
            PickerWidget(
              cameraAllowed: true,
              galleryAllowed: true,
              videoAllowed: false,
              filesAllowed: true,
              multipleAllowed: true,
              memoAllowed: false,
              attachments: attachments,
              onFilesPicked: onFilesPicked,
              captionAllowed: false,
              child: Center(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppTheme.primaryColor.withOpacity(0.1),
                  ),
                  child: ListTile(
                    //   tileColor: AppTheme.primaryColor.withOpacity(0.1),
                    leading: const Icon(Icons.album_rounded),
                    title: Text("Photos (${attachments.length})"),
                    subtitle: const Text("Tap to add Photo(s)"),
                    trailing: const Icon(Icons.add_a_photo),
                  ),
                ),
              ),
            ),
            if (attachments.isNotEmpty)
              const SizedBox(
                height: 10,
              ),
            if (attachments.isNotEmpty)
              SizedBox(
                height: 150,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: attachments.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: attachments[index].url.isNotEmpty
                            ? Image.file(
                                File(attachments[index].url),
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              )
                            : attachments[index].attachmentType.isEmpty
                                ? Image.memory(
                                    attachments[index].bytes!,
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  )
                                : attachments[index].attachmentType.isNotEmpty
                                    ? Image.file(
                                        File(attachments[index].attachmentType),
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.cover,
                                      )
                                    // Image.network(
                                    //     attachments[index]
                                    //         .attachmentType)
                                    : Image.asset(
                                        'assets/images/logo.png',
                                        height: 80,
                                        width: 90,
                                      ),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 50,
              child: CheckBoxContainer(
                  verticalPadding: 6,
                  check: globalEmployee,
                  tapped: changeStatus,
                  showBorder: true,
                  title: "Global Logistics Employee"),
            ),
            if (!globalEmployee)
              const SizedBox(
                height: 5,
              ),
            if (!globalEmployee)
              Card(
                color: AppTheme.primaryColor.withOpacity(0.1),
                child: TextField(
                  controller: otherCompanyName,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    labelText: "Company Name",
                  ),
                  cursorColor: AppTheme.primaryColor,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    FocusScope.of(context).nextFocus();
                  },
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: addEmployee, child: const Text("Add Employee"))
          ],
        ),
      ),
    );
  }
}
