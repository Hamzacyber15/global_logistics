import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/constants.dart';

class IndoorEquipmentCharges extends StatefulWidget {
  const IndoorEquipmentCharges({super.key});

  @override
  State<IndoorEquipmentCharges> createState() => _IndoorEquipmentChargesState();
}

class _IndoorEquipmentChargesState extends State<IndoorEquipmentCharges> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < Constants.indoorEquipmentType.length; i++)
          Column(
            children: [
              ListTile(
                leading: Image.asset(
                  Constants.indoorEquipmentType[i].image!,
                  height: 80,
                  width: 80,
                ),
                title: Text(Constants.indoorEquipmentType[i].title),
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
              ),
              const Divider()
            ],
          ),
      ],
    );
  }
}
