import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/constants.dart';
import 'package:mhs/models/package_model.dart';

class PackageInfo extends StatefulWidget {
  final PackageModel pm;
  const PackageInfo({required this.pm, super.key});

  @override
  State<PackageInfo> createState() => _PackageInfoState();
}

class _PackageInfoState extends State<PackageInfo> {
  int selectedOption = 1;

  List<String> title = [
    "Title",
    "Arabic Title",
    "Description",
    "Arabic Description",
    "Labour",
    "Equipment",
    "Container Size",
    "Estimated Delivery",
    "Price",
    "Category",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Constants.bigScreen = size.width > 700;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Center(
            child: SizedBox(
              width: Constants.bigScreen
                  ? MediaQuery.of(context).size.width / 2
                  : MediaQuery.of(context).size.width,
              child: ListView(
                children: [
                  for (int i = 0; i < title.length; i++)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: "${title[i]} : ",
                                style: TextStyle(
                                    color: AppTheme.blackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Raleway"),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: title[i] == "Title"
                                        ? widget.pm.packageTitle
                                        : title[i] == "Arabic Title"
                                            ? widget.pm.arabicPackageTitle
                                            : title[i] == "Description"
                                                ? widget.pm.description
                                                : title[i] ==
                                                        "Arabic Description"
                                                    ? widget
                                                        .pm.arabicDescription
                                                    : title[i] == "Labour"
                                                        ? widget.pm.labour
                                                            .toString()
                                                        : title[i] ==
                                                                "Equipment"
                                                            ? widget
                                                                .pm.equipment
                                                            : title[i] ==
                                                                    "Container Size"
                                                                ? widget.pm
                                                                    .containerSize
                                                                : title[i] ==
                                                                        "Estimated Delivery"
                                                                    ? widget.pm
                                                                        .estimatedDelivery
                                                                    : title[i] ==
                                                                            "Price"
                                                                        ? "${widget.pm.price.toString()} + Vat"
                                                                        : title[i] ==
                                                                                "Category"
                                                                            ? widget.pm.orderCategory
                                                                            : widget.pm.arabicDescription,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.blackColor,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Raleway"),
                                  ),
                                ],
                              ),
                            ),
                            // Divider()
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          )),
    );
  }
}
