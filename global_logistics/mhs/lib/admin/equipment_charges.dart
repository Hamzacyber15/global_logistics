import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mhs/admin/indoor_equipment_charges.dart';
import 'package:mhs/admin/outdoor_equipment_charges.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/constants.dart';

class EquipmentCharges extends StatefulWidget {
  const EquipmentCharges({super.key});

  @override
  State<EquipmentCharges> createState() => _EquipmentChargesState();
}

class _EquipmentChargesState extends State<EquipmentCharges> {
  int groupValueCount = 0;

  void changePage(Object count) {
    int i = count as int;
    setState(() {
      groupValueCount = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Equipment Charges"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CupertinoSlidingSegmentedControl(
                padding: const EdgeInsets.all(10),
                children: {
                  0: Text(
                    "Indoor",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: groupValueCount == 0
                            ? AppTheme.blackColor
                            : AppTheme.whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  1: Text(
                    "Outdoor",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: groupValueCount == 1
                            ? AppTheme.blackColor
                            : AppTheme.whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                },
                backgroundColor: AppTheme.primaryColor,
                groupValue: groupValueCount,
                onValueChanged: (index) {
                  changePage(index!);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            groupValueCount == 0
                ? const IndoorEquipmentCharges()
                : const OutdoorEquipmentCharges(),
            // for (int i = 0; i < Constants.equipmentType.length; i++)
            //   Column(
            //     children: [
            //       ListTile(
            //         leading: Image.asset(
            //           Constants.equipmentType[i].image!,
            //           height: 80,
            //           width: 80,
            //         ),
            //         title: Text(Constants.equipmentType[i].title),
            //         subtitle: TextField(
            //           // onChanged: (value) {
            //           //   sendData();
            //           // },
            //           //controller: ,
            //           keyboardType: TextInputType.emailAddress,
            //           decoration: const InputDecoration(
            //             prefixIcon: Icon(
            //               Icons.price_change,
            //               color: Colors.black,
            //             ),
            //             contentPadding: EdgeInsets.symmetric(vertical: 5),
            //             labelText: "Charges",
            //           ),
            //           cursorColor: AppTheme.primaryColor,
            //           textInputAction: TextInputAction.next,
            //           onEditingComplete: () {
            //             FocusScope.of(context).nextFocus();
            //           },
            //         ),
            //       ),
            //       Divider()
            //     ],
            //   ),
          ],
        ),
      ),
    );
  }
}
