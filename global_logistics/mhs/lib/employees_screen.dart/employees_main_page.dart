import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/constants.dart';
import 'package:mhs/employees_screen.dart/add_employee_form.dart';
import 'package:mhs/loading_widget.dart';
import 'package:mhs/models/employee_model.dart';
import 'package:mhs/widgets/data_table.dart';
import 'package:mhs/widgets/side_bar.dart';

class EmployeesMainPage extends StatefulWidget {
  const EmployeesMainPage({super.key});

  @override
  State<EmployeesMainPage> createState() => _EmployeesMainPageState();
}

class _EmployeesMainPageState extends State<EmployeesMainPage> {
  TextEditingController searchController = TextEditingController();
  bool loading = false;
  List<EmployeeModel> employeeList = [];
  List<EmployeeModel> filteredEmployeeList = [];
  List<String> titleList = [
    "Status",
    "Name",
    "Designation",
    "Mobile Number",
    "Id Card Card Number",
    "Global Logistics Employee",
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getEmployees();
  }

  void getEmployees() async {
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
    employeeList.clear();
    try {
      await FirebaseFirestore.instance
          .collection('employees')
          .where('status', isEqualTo: "active")
          .get()
          .then((value) {
        for (var doc in value.docs) {
          EmployeeModel? em = EmployeeModel.getBusinessList(doc);
          if (em != null) {
            employeeList.add(em);
          }
        }
      });
      setState(() {
        filteredEmployeeList = employeeList;
        loading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }

  void addItem() async {
    await showGeneralDialog(
      transitionDuration: const Duration(milliseconds: 500),
      barrierDismissible: true,
      barrierLabel: "",
      context: context,
      pageBuilder: (_, __, ___) {
        return const SideBar(
          child: AddEmployeeScreen(),
        );
      },
    );
    getEmployees();
  }

  void searchServices(String x) {
    if (x.isNotEmpty) {
      filteredEmployeeList = employeeList
          .where((element) =>
              element.name.toLowerCase().contains(x) ||
              element.idCardNumber.toLowerCase().contains(x))
          .toList();
      //log(filteredServices.length.toString());
    } else {
      filteredEmployeeList = employeeList;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employees"),
      ),
      body: loading
          ? const LoadingWidget()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Card(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    child: TextField(
                      onChanged: (value) {
                        searchServices(value);
                      },
                      controller: searchController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                        labelText: "Search Employee By Name",
                      ),
                      cursorColor: AppTheme.primaryColor,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        FocusScope.of(context).nextFocus();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DataTableWidget(
                        titleList: titleList,
                        rowHeight: 40,
                        rowElement: List.generate(
                            filteredEmployeeList.length,
                            (index) =>
                                statsDataRow(filteredEmployeeList[index])),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: addItem,
        tooltip: 'Add Employee',
        backgroundColor: AppTheme.primaryColor,
        child: Icon(
          Icons.add,
          color: AppTheme.whiteColor,
        ),
      ),
    );
  }

  DataRow statsDataRow(EmployeeModel em) {
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
          Text(em.name),
        ),
        DataCell(
          Text(em.designation),
        ),
        DataCell(
          Text(em.contactNumber),
        ),
        DataCell(
          Text(em.idCardNumber),
        ),
        DataCell(
          Text(em.globalEmployee.toString()),
        ),
      ],
    );
  }
}
