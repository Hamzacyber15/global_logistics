import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/business_screens.dart/business_main_page.dart';
import 'package:mhs/constants.dart';
import 'package:mhs/loading_widget.dart';
import 'package:mhs/models/business/business_profile.dart';
import 'package:mhs/widgets/data_table.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  bool loading = false;
  List<BusinessProfileModel> businessList = [];
  List<String> titleList = [
    "Status",
    "Business Name",
    "Business Name Arabic",
    "Company Registration",
    "Phone Number",
    // "Business Area",
    // "Business Area",
    "Selected Country",
    "Name",
    "Company Address",
    "Email",
  ];
  @override
  void initState() {
    super.initState();
    getBusinessProfile();
  }

  void getBusinessProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    setState(() {
      loading = true;
    });
    try {
      await FirebaseFirestore.instance
          .collection('business')
          .where('status', isNotEqualTo: "")
          .get()
          .then((value) {
        for (var doc in value.docs) {
          BusinessProfileModel? bp = BusinessProfileModel.getBusinessList(doc);
          if (bp != null) {
            businessList.add(bp);
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

  Future<void> dialogueBox(BuildContext context, BusinessProfileModel bp) {
    return showDialog<void>(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: ((ctx, setState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AlertDialog(
                  title: Image.asset(
                    'assets/images/logo.png',
                    height: 80,
                    width: 90,
                  ),
                  actions: <Widget>[
                    Text(
                      "${"Approve/Disapprove"} ${bp.nameEnglish}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: AppTheme.greenColor,
                            ),
                            child: Text(
                              'Approve',
                              style: TextStyle(color: AppTheme.whiteColor),
                            ),
                            onPressed: () => setStatus(bp, "approve")),
                        const SizedBox(
                          width: 5,
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: AppTheme.redColor,
                            ),
                            child: Text(
                              'Reject',
                              style: TextStyle(color: AppTheme.whiteColor),
                            ),
                            onPressed: () => setStatus(bp, "reject")),
                        const SizedBox(
                          width: 5,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: AppTheme.redColor,
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: AppTheme.whiteColor),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          }),
        );
      },
    );
  }

  void setStatus(BusinessProfileModel bm, String status) async {
    Navigator.of(context).pop();
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
      await FirebaseFirestore.instance.collection('business').doc(bm.id).set({
        'status': status,
      }, SetOptions(merge: true)).then((value) {
        Constants.showMessage(context, "Status Updates");
      });
      getBusinessProfile();
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }

  String combineStrings(String firstString, String secondString) {
    return '$firstString, $secondString';
  }

  void navBusinessProfile(BusinessProfileModel cr) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return BusinessMainPage(cr: cr);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Business Request"),
      ),
      body: loading
          ? const LoadingWidget()
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataTableWidget(
                    titleList: titleList,
                    rowHeight: 40,
                    rowElement: List.generate(businessList.length,
                        (index) => statsDataRow(businessList[index])),
                  ),
                ),
              ),
            ),
    );
  }

  DataRow statsDataRow(BusinessProfileModel cr) {
    return DataRow(
      onSelectChanged: (value) {
        navBusinessProfile(cr);
      },
      cells: [
        DataCell(
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: cr.status == "pending"
                  ? AppTheme.redColor
                  : AppTheme.greenColor, // Background color
            ),
            onPressed: () => dialogueBox(context, cr),
            child: Text(Constants.capitalizeFirstLetter(cr.status)),
          ),
        ),
        DataCell(
          Text(cr.nameEnglish),
        ),
        DataCell(
          Text(cr.nameArabic),
        ),
        DataCell(
          Text(cr.registrationNum),
        ),
        DataCell(
          Text(cr.phoneNumber),
        ),
        // for (int i = 0; i < cr.businessAreas.length; i++)
        //   DataCell(
        //     Text(combineStrings(
        //         cr.businessAreas[i].title, cr.businessAreas[i].value)),
        //   ),
        DataCell(
          Text(cr.userCountry),
        ),
        DataCell(
          Text(cr.userName),
        ),
        DataCell(
          Text(cr.businessAddress),
        ),
        DataCell(
          Text(cr.userEmail),
        ),
      ],
    );
  }
}
