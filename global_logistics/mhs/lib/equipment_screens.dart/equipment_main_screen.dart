import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/constants.dart';
import 'package:mhs/equipment_screens.dart/add_equipment_page.dart';
import 'package:mhs/loading_widget.dart';
import 'package:mhs/models/equipment_model.dart';
import 'package:mhs/widgets/data_table.dart';
import 'package:mhs/widgets/side_bar.dart';

class EquipmentMainScreens extends StatefulWidget {
  const EquipmentMainScreens({super.key});

  @override
  State<EquipmentMainScreens> createState() => _EquipmentMainScreensState();
}

class _EquipmentMainScreensState extends State<EquipmentMainScreens> {
  bool loading = false;
  List<EquipmentModel> equipmentList = [];
  List<String> titleList = [
    "Status",
    "Equipment Brand",
    "Equipment Capacity",
    "Equipment Type",
    "Time Added",
  ];

  @override
  void initState() {
    super.initState();
    getEquipment();
  }

  void getEquipment() async {
    if (loading) {
      return;
    }
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    setState(() {
      loading = true;
    });
    try {
      await FirebaseFirestore.instance
          .collection('equipment')
          .where('status', isEqualTo: "active")
          .get()
          .then((value) {
        for (var doc in value.docs) {
          EquipmentModel? em = EquipmentModel.getBusinessList(doc);
          if (em != null) {
            equipmentList.add(em);
          }
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  void addItem() async {
    await showGeneralDialog(
      transitionDuration: const Duration(milliseconds: 500),
      barrierDismissible: true,
      barrierLabel: "",
      context: context,
      pageBuilder: (_, __, ___) {
        return const SideBar(
          child: AddEquipmentPage(),
        );
      },
    );
    getEquipment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Equipment"),
      ),
      body: loading
          ? const LoadingWidget()
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DataTableWidget(
                  titleList: titleList,
                  rowHeight: 40,
                  rowElement: List.generate(equipmentList.length,
                      (index) => statsDataRow(equipmentList[index])),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: addItem,
        tooltip: 'Add Equipment',
        backgroundColor: AppTheme.primaryColor,
        child: Icon(
          Icons.add,
          color: AppTheme.whiteColor,
        ),
      ),
    );
  }

  DataRow statsDataRow(EquipmentModel em) {
    return DataRow(
      cells: [
        DataCell(
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: em.status == "pending"
                  ? AppTheme.redColor
                  : AppTheme.greenColor, // Background color
            ),
            onPressed: () {},
            child: Text(Constants.capitalizeFirstLetter(em.status)),
          ),
        ),
        DataCell(
          Text(em.equipmentBrand),
        ),
        DataCell(
          Text(em.equipmentCapacity),
        ),
        DataCell(
          Text(em.equipmentType),
        ),
        DataCell(
          Text(Constants.timestampToString(em.timestamp)),
        ),
      ],
    );
  }
}
