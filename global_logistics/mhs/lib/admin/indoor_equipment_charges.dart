import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/constants.dart';
import 'package:mhs/models/equipment_type_model.dart';
import 'package:mhs/provider/storage_provider.dart';
import 'package:provider/provider.dart';

class IndoorEquipmentCharges extends StatefulWidget {
  const IndoorEquipmentCharges({super.key});

  @override
  State<IndoorEquipmentCharges> createState() => _IndoorEquipmentChargesState();
}

class _IndoorEquipmentChargesState extends State<IndoorEquipmentCharges> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getIndoorEquipment();
  }

  void getIndoorEquipment() {
    Provider.of<StorageProvider>(context, listen: false).getEquipment("Indoor");
  }

  @override
  Widget build(BuildContext context) {
    List<EquipmentTypeModel> indoorEquipmentType =
        Provider.of<StorageProvider>(context).indoorEquipment;
    return Column(
      children: [
        for (int i = 0; i < indoorEquipmentType.length; i++)
          Column(
            children: [
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    indoorEquipmentType[i].imageIcon,
                    height: 80,
                    width: 80,
                  ),
                ),
                title: Text(
                  indoorEquipmentType[i].name,
                  style: TextStyle(color: AppTheme.blackColor),
                ),
                // subtitle:
                // TextField(
                //   // onChanged: (value) {
                //   //   sendData();
                //   // },
                //   //controller: ,
                //   keyboardType: TextInputType.emailAddress,
                //   decoration: InputDecoration(
                //       prefixIcon: const Icon(
                //         Icons.price_change,
                //         color: Colors.black,
                //       ),
                //       contentPadding: const EdgeInsets.symmetric(vertical: 5),
                //       labelText: indoorEquipmentType[i].name //"Charges",
                //       ),
                //   cursorColor: AppTheme.primaryColor,
                //   textInputAction: TextInputAction.next,
                //   onEditingComplete: () {
                //     FocusScope.of(context).nextFocus();
                //   },
                // ),
              ),
              const Divider()
            ],
          ),
      ],
    );
  }
}
