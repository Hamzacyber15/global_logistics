import 'dart:io';

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
