import 'package:flutter/material.dart';
import 'package:mhs/admin/admin_dasboard.dart';
import 'package:mhs/admin/admin_side_menu.dart';
import 'package:mhs/admin/equipment_charges.dart';
import 'package:mhs/constants.dart';
import 'package:mhs/employees_screen.dart/employees_main_page.dart';
import 'package:mhs/equipment_screens.dart/equipment_main_screen.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  String type = "adminDashboard";

  Widget getBody() {
    if (type == "adminDashboard") {
      return const AdminDashboard();
    } else if (type == "employees") {
      return const EmployeesMainPage();
    } else if (type == "equipment") {
      return const EquipmentMainScreens();
    } else if (type == "equipmentCharges") {
      return const EquipmentCharges();
    }

    return Container();
  }

  void getData(String t) {
    setState(() {
      type = t;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Constants.bigScreen = size.width > 700;
    return Scaffold(
      // key: context.read<MainProvider>().scaffoldKey,
      //drawer: const AdminSideMenu(),
      body: SafeArea(
          child: Constants.bigScreen
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: AdminSideMenu(
                      tapped: getData,
                    )),
                    Expanded(flex: 5, child: getBody())
                  ],
                )
              : const AdminDashboard()),
    );
  }
}
