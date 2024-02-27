import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/loading_widget.dart';
import 'package:mhs/models/employee_model.dart';

class SelectDriver extends StatefulWidget {
  final String? type;
  const SelectDriver({this.type, super.key});

  @override
  State<SelectDriver> createState() => _SelectDriverState();
}

class _SelectDriverState extends State<SelectDriver> {
  TextEditingController searchController = TextEditingController();
  bool loading = false;
  List<EmployeeModel> employeeList = [];
  List<EmployeeModel> filteredEmployeeList = [];
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
  void initState() {
    super.initState();
    getEmployees();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
    String type = "";
    if (widget.type != null) {
      if (widget.type != "Electric TukTuk") {
        type = "Forklift Driver";
      } else {
        type = "TukTuk Driver";
      }
    }
    try {
      await FirebaseFirestore.instance
          .collection('employees')
          .where('designation', isEqualTo: type)
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

  void selectDrivers(EmployeeModel e) {
    Navigator.of(context).pop(e);
  }

  void searchServices(String x) {
    if (x.isNotEmpty) {
      filteredEmployeeList = employeeList
          .where((element) => element.name.toLowerCase().contains(x))
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
        title: const Text("Select Drivers"),
      ),
      body: loading
          ? const LoadingWidget()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: filteredEmployeeList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () =>
                                  selectDrivers(filteredEmployeeList[index]),
                              tileColor: AppTheme.primaryColor.withOpacity(0.1),
                              leading: const Icon(Icons.car_rental),
                              title: Text(filteredEmployeeList[index].name),
                              subtitle:
                                  Text(filteredEmployeeList[index].designation),
                              trailing: const Icon(Icons.rounded_corner),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
