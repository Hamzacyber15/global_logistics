import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/constants.dart';
import 'package:mhs/widgets/custom_button.dart';

class OutdoorEquipmentCharges extends StatefulWidget {
  const OutdoorEquipmentCharges({super.key});

  @override
  State<OutdoorEquipmentCharges> createState() =>
      _OutdoorEquipmentChargesState();
}

class _OutdoorEquipmentChargesState extends State<OutdoorEquipmentCharges> {
  bool loading = false;

  void updatePrice() async {
    if (loading) {
      return;
    }
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    await FirebaseFirestore.instance
        .collection('equipmentCharges')
        .doc()
        .set({});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < Constants.outDoorEquipmentType.length; i++)
          Column(
            children: [
              ListTile(
                leading: Image.asset(
                  Constants.outDoorEquipmentType[i].image!,
                  height: 80,
                  width: 80,
                ),
                title: Text(Constants.outDoorEquipmentType[i].title),
                subtitle: TextField(
                  // onChanged: (value) {
                  //   sendData();
                  // },
                  //controller: ,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.price_change,
                      color: Colors.black,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    labelText: "Charges",
                  ),
                  cursorColor: AppTheme.primaryColor,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    FocusScope.of(context).nextFocus();
                  },
                ),
                // trailing: SizedBox(
                //   width: 140,
                //   height: 50,
                //   child: CustomButton(title: "Update", tapped: () {}),
                // ),
              ),
              const Divider()
            ],
          ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 140,
          height: 50,
          child: CustomButton(title: "Update", tapped: () {}),
        )
      ],
    );
  }
}
