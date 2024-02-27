import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/constants.dart';
import 'package:mhs/employees_screen.dart/select_driver.dart';
import 'package:mhs/models/drop_down_menu_model.dart';
import 'package:mhs/models/employee_model.dart';
import 'package:mhs/widgets/drop_down_menu.dart';

class AddEquipmentPage extends StatefulWidget {
  const AddEquipmentPage({super.key});

  @override
  State<AddEquipmentPage> createState() => _AddEquipmentPageState();
}

class _AddEquipmentPageState extends State<AddEquipmentPage> {
  TextEditingController equipmentNumber = TextEditingController();
  TextEditingController equipmentBrand = TextEditingController();
  TextEditingController equipmentCapacity = TextEditingController();
  DropDownMenuDataModel equipment = Constants.equipmentType[0];
  String equipmentType = "";
  bool loading = false;
  EmployeeModel selectedEmployee = EmployeeModel(
      id: "",
      attachments: [],
      contactNumber: "",
      designation: "",
      idCardNumber: "",
      name: "",
      otherCompany: "",
      status: "",
      timestamp: Timestamp.now(),
      userId: "",
      globalEmployee: false);

  @override
  void dispose() {
    equipmentBrand.dispose();
    equipmentCapacity.dispose();
    super.dispose();
  }

  void message(String title) {
    Constants.showMessage(context, title);
  }

  void addEquipment() async {
    if (loading) {
      return;
    }
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    bool check = checkCredentials();
    if (!check) {
      return;
    }
    setState(() {
      loading = true;
    });
    try {
      await FirebaseFirestore.instance.collection('equipment').doc().set({
        'equipmentType': equipmentType,
        'equipmentBrand': equipmentBrand.text.trim(),
        'equipmentCapacity': equipmentCapacity.text.trim(),
        'equipmentDriverId': selectedEmployee.id,
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
    if (equipmentNumber.text.trim().isEmpty) {
      Constants.showMessage(context, "Equipment Number Is Empty");
    } else if (equipmentBrand.text.trim().isEmpty) {
      Constants.showMessage(context, "Equipment Brand Is Empty");
    } else if (equipmentType.isEmpty) {
      Constants.showMessage(context, "Select From Equipment Type");
    } else if (equipmentCapacity.text.trim().isEmpty) {
      Constants.showMessage(context, "Equipment Capacity Is empty");
    } else if (selectedEmployee.id.isEmpty) {
      Constants.showMessage(context, "Please select driver");
    } else {
      result = true;
    }
    return result;
  }

  void getValues(String type, String value, String id) {
    equipmentType = value;
  }

  void navDriversInfo() async {
    EmployeeModel? temp =
        await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return SelectDriver(type: equipmentType);
    }));
    if (temp != null) {
      setState(() {
        selectedEmployee = temp;
      });
    }
  }

  void clearEmployee() {
    selectedEmployee = EmployeeModel(
        id: "",
        attachments: [],
        contactNumber: "",
        designation: "",
        idCardNumber: "",
        name: "",
        otherCompany: "",
        status: "",
        timestamp: Timestamp.now(),
        userId: "",
        globalEmployee: false);
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
              "Add Equipment",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Card(
              color: AppTheme.primaryColor.withOpacity(0.1),
              child: TextField(
                controller: equipmentNumber,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  labelText: "Equipment Number",
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
                  "Equipment Type",
                  const Icon(Icons.person),
                  Constants.equipmentType,
                  equipment,
                  "equipment"),
            ),
            Card(
              color: AppTheme.primaryColor.withOpacity(0.1),
              child: TextField(
                controller: equipmentBrand,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  labelText: "Brand",
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
                controller: equipmentCapacity,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  labelText: "Max/Load Capacity",
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
              child: ListTile(
                onTap: navDriversInfo,
                leading: const Icon(Icons.details),
                title: const Text("Equipment Driver Details"),
                trailing: const Icon(Icons.chevron_right_sharp),
              ),
            ),
            if (selectedEmployee.id.isNotEmpty)
              Card(
                color: AppTheme.primaryColor.withOpacity(0.1),
                child: ListTile(
                    title: Text(selectedEmployee.name),
                    subtitle: Text(selectedEmployee.designation),
                    trailing: IconButton(
                        onPressed: clearEmployee,
                        icon: Icon(
                          Icons.delete_outline,
                          color: AppTheme.redColor,
                        ))
                    // Icon(
                    //   Icons.delete_forever,
                    //   color: AppTheme.redColor,
                    // ),
                    ),
              ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: addEquipment, child: const Text("Add Equipment"))
          ],
        ),
      ),
    );
  }
}
