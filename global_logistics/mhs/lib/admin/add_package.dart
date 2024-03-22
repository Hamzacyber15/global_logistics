import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/constants.dart';
import 'package:mhs/models/drop_down_menu_model.dart';
import 'package:mhs/models/package_model.dart';
import 'package:mhs/provider/storage_provider.dart';
import 'package:mhs/widgets/check_box_container.dart';
import 'package:mhs/widgets/drop_down_menu.dart';
import 'package:provider/provider.dart';

class AddPackage extends StatefulWidget {
  final PackageModel? pm;
  const AddPackage({this.pm, super.key});

  @override
  State<AddPackage> createState() => _AddPackageState();
}

class _AddPackageState extends State<AddPackage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController arabicTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController arabicDescriptionController = TextEditingController();
  TextEditingController numberofLabourController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController containerSizeController = TextEditingController();
  TextEditingController estimatedDelivery = TextEditingController();
  DropDownMenuDataModel equipment = Constants.equipmentType[0];
  String selectedCategory = "";
  bool labour = false;
  bool loading = false;
  String selectedEquipment = "";
  String selectedEquipmentId = "";

  @override
  void initState() {
    super.initState();
    if (widget.pm != null) {
      titleController.text = widget.pm!.packageTitle;
      arabicTitleController.text = widget.pm!.arabicPackageTitle;
      descriptionController.text = widget.pm!.description;
      arabicDescriptionController.text = widget.pm!.arabicDescription;
      numberofLabourController.text = widget.pm!.labour.toString();
      priceController.text = widget.pm!.price.toString();
      containerSizeController.text = widget.pm!.containerSize;
      estimatedDelivery.text = widget.pm!.estimatedDelivery;
      setState(() {
        selectedCategory = widget.pm!.orderCategory;
        if (widget.pm!.labour != 0) {
          labour = true;
        }
      });
    }

    getEquipment();
  }

  @override
  void dispose() {
    titleController.dispose();
    arabicTitleController.dispose();
    arabicDescriptionController.dispose();
    descriptionController.dispose();
    numberofLabourController.dispose();
    priceController.dispose();
    containerSizeController.dispose();
    estimatedDelivery.dispose();

    super.dispose();
  }

  void changeStatus() {
    labour = !labour;
    setState(() {});
  }

  void getValues(String type, String value, String id) {
    if (type == "orderCategory") {
      selectedCategory = value;
    } else {
      selectedEquipment = value;
      selectedEquipmentId = id;
    }
    setState(() {});
  }

  void getEquipment() {
    Provider.of<StorageProvider>(context, listen: false)
        .getEquipment("Outdoor");
    Provider.of<StorageProvider>(context, listen: false).getEquipment("Indoor");
  }

  bool checkCredential() {
    bool result = false;
    if (titleController.text.trim().isEmpty) {
      Constants.showMessage(context, "Please Enter Title");
    } else if (arabicTitleController.text.trim().isEmpty) {
      Constants.showMessage(context, "Please Enter Arabic Title");
    } else if (descriptionController.text.trim().isEmpty) {
      Constants.showMessage(context, "Please Enter Description");
    } else if (arabicDescriptionController.text.trim().isEmpty) {
      Constants.showMessage(context, "Please Enter Arabic Description");
    } else if (containerSizeController.text.trim().isEmpty) {
      Constants.showMessage(context, "Please Enter Container Size");
    } else if (priceController.text.trim().isEmpty) {
      Constants.showMessage(context, "Please Enter Price");
    } else if (labour) {
      if (numberofLabourController.text.trim().isEmpty) {
        Constants.showMessage(context, "Please Enter Number of Labour");
      } else {
        result = true;
      }
    } else {
      result = true;
    }
    return result;
  }

  void save() async {
    if (loading) {
      return;
    }
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    double l = double.tryParse(numberofLabourController.text.trim()) ?? 0;
    double p = double.tryParse(priceController.text.trim()) ?? 0;
    bool check = checkCredential();
    if (!check) {
      return;
    }
    try {
      await FirebaseFirestore.instance.collection('packages').doc().set({
        'packageTitle': titleController.text.trim(),
        'arabicPackageTitle': arabicTitleController.text.trim(),
        'description': descriptionController.text.trim(),
        'arabicDescription': arabicDescriptionController.text.trim(),
        'labour': l,
        'price': p,
        'containerSize': containerSizeController.text.trim(),
        'estimatedDelivery': estimatedDelivery.text.trim(),
        'orderCategory': selectedCategory,
        'equipment': selectedEquipment,
        'equipmentId': selectedEquipmentId,
        'timestamp': FieldValue.serverTimestamp(),
        'status': "active",
      }).then((value) {
        Constants.showMessage(context, "Package Added Successfully");
        Navigator.of(context).pop();
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    List<DropDownMenuDataModel> indoorEquipment =
        Provider.of<StorageProvider>(context).indoorEquipmentDropDown;
    List<DropDownMenuDataModel> outdoorEquipment =
        Provider.of<StorageProvider>(context).outdoorEquipmentDropDown;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Packages"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: ListView(
              children: [
                Card(
                  color: AppTheme.whiteColor,
                  child: TextField(
                    controller: titleController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.info,
                        color: Colors.black,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      labelText: "Package Title",
                    ),
                    cursorColor: AppTheme.primaryColor,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                ),
                Card(
                  color: AppTheme.whiteColor,
                  child: TextField(
                    controller: arabicTitleController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.info,
                          color: Colors.black,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                        labelText:
                            "عنوان الحزمة (باللغة العربية)" //"Package Title (Arabic)",
                        ),
                    cursorColor: AppTheme.primaryColor,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                ),
                Card(
                  color: AppTheme.whiteColor,
                  child: TextField(
                    maxLines: 3,
                    controller: descriptionController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.info,
                        color: Colors.black,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      labelText: "Description",
                    ),
                    cursorColor: AppTheme.primaryColor,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                ),
                Card(
                  color: AppTheme.whiteColor,
                  child: TextField(
                    maxLines: 3,
                    controller: arabicDescriptionController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.info,
                        color: Colors.black,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      labelText: "الوصف (باللغة العربية)",
                    ),
                    cursorColor: AppTheme.primaryColor,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                ),
                Card(
                  color: AppTheme.whiteColor,
                  child: TextField(
                    controller: containerSizeController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.info,
                        color: Colors.black,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      labelText: "Container Size",
                    ),
                    cursorColor: AppTheme.primaryColor,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                ),
                Card(
                  color: AppTheme.whiteColor,
                  child: TextField(
                    controller: estimatedDelivery,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.info,
                        color: Colors.black,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      labelText: "Estimated Delivery",
                    ),
                    cursorColor: AppTheme.primaryColor,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                ),
                Card(
                  color: AppTheme.whiteColor,
                  child: TextField(
                    controller: priceController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.info,
                        color: Colors.black,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      labelText: "Price (+ Vat)",
                    ),
                    cursorColor: AppTheme.primaryColor,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CheckBoxContainer(
                          check: labour,
                          tapped: changeStatus,
                          title: "Provided Staff ?"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (labour)
                      Expanded(
                        child: Card(
                          color: AppTheme.whiteColor,
                          child: TextField(
                            controller: numberofLabourController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.info,
                                color: Colors.black,
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 5),
                              labelText: "Number of Labour",
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
                if (selectedCategory == "Indoor")
                  Card(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    child: DropDownMenu(
                      getValues,
                      "Indoor Equipment",
                      // const Icon(Icons.person),
                      indoorEquipment,
                      equipment,
                      "equipmentType",
                    ),
                  ),
                if (selectedCategory == "Outdoor")
                  Card(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    child: DropDownMenu(
                      getValues,
                      "Outdoor Equipment",
                      // const Icon(Icons.person),
                      outdoorEquipment,
                      equipment,
                      "equipmentType",
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                if (widget.pm == null)
                  ElevatedButton(onPressed: save, child: const Text("Save"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
