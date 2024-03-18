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

class AddEquipment extends StatefulWidget {
  const AddEquipment({super.key});

  @override
  State<AddEquipment> createState() => _AddEquipmentState();
}

class _AddEquipmentState extends State<AddEquipment> {
  bool loading = false;
  TextEditingController equipmentName = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController thirtyprice = TextEditingController();
  TextEditingController sixtyprice = TextEditingController();
  DropDownMenuDataModel equipment = Constants.equipmentType[0];
  List<AttachmentModel> attachments = [];
  String selectedCategory = "";

  @override
  void dispose() {
    equipmentName.dispose();
    price.dispose();
    thirtyprice.dispose();
    sixtyprice.dispose();
    super.dispose();
  }

  void getValues(String type, String value, String id) {
    if (type == "orderCategory") {
      selectedCategory = value;
    }
    setState(() {});
  }

  void onFilesPicked(List<AttachmentModel> files) {
    setState(() {
      attachments = files;
    });
  }

  void saveEquipment() async {
    if (loading) {
      return;
    }
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    List<String> urls = [];
    for (AttachmentModel attachment in attachments) {
      String url = await Constants.uploadAttachment(attachment);
      urls.add(url);
    }
    if (urls.isEmpty) {
      message("Please attach Front & Back Side of the id card");
      return;
    }
    bool check = checkCredentials();
    if (!check) {
      return;
    }
    setState(() {
      loading = true;
    });
    double p = double.tryParse(price.text.trim()) ?? 0;
    double thiPrice = double.tryParse(thirtyprice.text.trim()) ?? 0;
    double sPrice = double.tryParse(sixtyprice.text.trim()) ?? 0;
    try {
      await FirebaseFirestore.instance.collection('equipment').doc().set({
        'equipmentTitle': equipmentName.text.trim(),
        'equipmentCategory': selectedCategory,
        'equipmentIcon': urls[0],
        'status': "active",
        'price': p,
        'thirtyMinutePrice': thiPrice,
        'sixtyMinutesPrice': sPrice,
      }).then((value) {
        Constants.showMessage(context, "Equipment Added");
        Navigator.of(context).pop();
      });
      setState(() {
        loading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void message(String title) {
    Constants.showMessage(context, title);
  }

  bool checkCredentials() {
    bool result = false;
    if (equipmentName.text.trim().isEmpty) {
      Constants.showMessage(context, "Please Enter Equipment title");
    } else if (selectedCategory.isEmpty) {
      Constants.showMessage(context, "Please Select Equipment Type");
    } else if (selectedCategory == "Indoor") {
      if (price.text.trim().isEmpty) {
        Constants.showMessage(context, "Please enter 15 Minutes price");
      } else if (thirtyprice.text.isEmpty) {
        Constants.showMessage(context, "Please Enter Thirty Minutes Price");
      } else if (sixtyprice.text.isEmpty) {
        Constants.showMessage(context, "Please Enter Thirty Minutes Price");
      } else {
        result = true;
      }
    } else if (selectedCategory == "Outdoor") {
      if (price.text.trim().isEmpty) {
        Constants.showMessage(context, "Please Enter Price");
      } else {
        result = true;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Equipment"),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
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
                                  : Image.memory(
                                      attachments[index].bytes!,
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    )),
                        );
                      },
                    ),
                  ),
              const SizedBox(
                height: 20,
              ),
              Card(
                color: AppTheme.whiteColor,
                child: TextField(
                  controller: equipmentName,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    labelText: "Equipment Title",
                  ),
                  cursorColor: AppTheme.primaryColor,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    FocusScope.of(context).nextFocus();
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                color: AppTheme.primaryColor.withOpacity(0.1),
                child: DropDownMenu(
                  getValues,
                  "Equipment Type",
                  // const Icon(Icons.person),
                  Constants.orderCategory,
                  equipment,
                  "orderCategory",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      color: AppTheme.whiteColor,
                      child: TextField(
                        controller: price,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 5),
                          labelText: selectedCategory == "Indoor"
                              ? "15 Minutes Price (OMR)"
                              : "Price (OMR)",
                        ),
                        cursorColor: AppTheme.primaryColor,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          FocusScope.of(context).nextFocus();
                        },
                      ),
                    ),
                  ),
                  if (selectedCategory == "Indoor")
                    Expanded(
                      child: Card(
                        color: AppTheme.whiteColor,
                        child: TextField(
                          controller: thirtyprice,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            labelText: "30 Minutes Price (OMR)",
                          ),
                          cursorColor: AppTheme.primaryColor,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            FocusScope.of(context).nextFocus();
                          },
                        ),
                      ),
                    ),
                  if (selectedCategory == "Indoor")
                    Expanded(
                      child: Card(
                        color: AppTheme.whiteColor,
                        child: TextField(
                          controller: sixtyprice,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            labelText: "60 Minutes Price (OMR)",
                          ),
                          cursorColor: AppTheme.primaryColor,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            FocusScope.of(context).nextFocus();
                          },
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(onPressed: () {}, child: const Text("Save"))
            ],
          ),
        ),
      ),
    );
  }
}
