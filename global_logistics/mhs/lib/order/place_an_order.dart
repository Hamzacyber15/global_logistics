import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/constants.dart';
import 'package:mhs/models/drop_down_menu_model.dart';
import 'package:mhs/widgets/check_box_container.dart';
import 'package:mhs/widgets/drop_down_menu.dart';

class PlaceAnOrder extends StatefulWidget {
  const PlaceAnOrder({super.key});

  @override
  State<PlaceAnOrder> createState() => _PlaceAnOrderState();
}

class _PlaceAnOrderState extends State<PlaceAnOrder> {
  bool loading = false;
  List<String> equipmentType = ["Tuk Tuk", "Fork Lift"];
  String selectedBlock = "";
  DropDownMenuDataModel storage = Constants.coldStorageBlock[0];
  List<String> dropLocation = [
    "Cold Storage",
    "Dry Store",
    "Onion Shade",
    "Potato Shade"
  ];
  List<bool> dropLocationBool = [
    false,
    false,
    false,
    false,
  ];
  List<bool> equipmentTypeBool = [false, false];

  void changeStatus(int i) {
    setState(() {
      equipmentTypeBool[i] = !equipmentTypeBool[i];
    });
  }

  void changeLocationStatus(int selectedIndex) {
    dropLocationBool[selectedIndex] = true;

    for (int i = 0; i < dropLocationBool.length; i++) {
      if (i != selectedIndex) {
        dropLocationBool[i] = false;
      }
    }
    setState(() {});
  }

  void getValues(String type, String value, String id) {
    selectedBlock = value;
  }

  void getColdStorage() async {
    if (loading) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Place An Order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < equipmentType.length; i++)
              Card(
                child: SizedBox(
                  height: 50,
                  child: CheckBoxContainer(
                      verticalPadding: 4,
                      check: equipmentTypeBool[i],
                      tapped: () => changeStatus(i),
                      showBorder: true,
                      title: equipmentType[i]),
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            // Container(
            //   padding: const EdgeInsets.all(12),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(12),
            //       color: AppTheme.primaryColor),
            //   child: Text(
            //     "Select Unloading Location",
            //     style: TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold,
            //         color: AppTheme.whiteColor),
            //   ),
            // ),
            Text(
              "Select Unloading Location",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor),
            ),
            const SizedBox(
              height: 5,
            ),
            for (int i = 0; i < dropLocation.length; i++)
              Card(
                child: SizedBox(
                  height: 50,
                  child: CheckBoxContainer(
                      verticalPadding: 4,
                      check: dropLocationBool[i],
                      tapped: () => changeLocationStatus(i),
                      showBorder: true,
                      title: dropLocation[i]),
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            if (dropLocationBool[0])
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Cold Storage Block",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor),
                  ),
                  Card(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    child: DropDownMenu(
                        getValues,
                        "Block",
                        const Icon(Icons.build),
                        Constants.coldStorageBlock,
                        storage,
                        "block"),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
