import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mhs/admin/add_equipment.dart';
import 'package:mhs/admin/indoor_equipment_charges.dart';
import 'package:mhs/admin/outdoor_equipment_charges.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/provider/storage_provider.dart';
import 'package:provider/provider.dart';

class EquipmentCharges extends StatefulWidget {
  const EquipmentCharges({super.key});

  @override
  State<EquipmentCharges> createState() => _EquipmentChargesState();
}

class _EquipmentChargesState extends State<EquipmentCharges> {
  int groupValueCount = 0;

  @override
  void initState() {
    super.initState();
    getIndoorEquipment();
  }

  void getIndoorEquipment() {
    Provider.of<StorageProvider>(context, listen: false).getEquipment("Indoor");
  }

  void changePage(Object count) {
    int i = count as int;
    setState(() {
      groupValueCount = i;
    });
  }

  void navNewEquipment() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const AddEquipment();
    }));
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navNewEquipment,
        label: const Text("Add Equipment"),
        tooltip: 'Add Equipment',
        elevation: 12,
        focusElevation: 5,
        splashColor: AppTheme.greenColor,
        backgroundColor: AppTheme.primaryColor,
        hoverColor: AppTheme.orangeColor,
        hoverElevation: 50,
        icon: Icon(
          Icons.add,
          color: AppTheme.whiteColor,
        ),
      ),
    );
  }
}
