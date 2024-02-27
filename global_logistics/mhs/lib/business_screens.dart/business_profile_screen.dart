import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/constants.dart';
import 'package:mhs/models/business/business_profile.dart';

class BusinessProfileScreen extends StatefulWidget {
  final BusinessProfileModel cr;
  const BusinessProfileScreen({required this.cr, super.key});

  @override
  State<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.info,
                                  color: AppTheme.primaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "Name : ",
                                    style: TextStyle(
                                        color: AppTheme.blackColor,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Raleway"),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: widget.cr.nameEnglish,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: AppTheme.blackColor,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Raleway"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.notifications,
                                  color: AppTheme.primaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "Status : ",
                                    style: TextStyle(
                                        color: widget.cr.status == "pending"
                                            ? AppTheme.redColor
                                            : AppTheme.blackColor,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Raleway"),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: Constants.capitalizeFirstLetter(
                                            widget.cr.status),
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: widget.cr.status == "pending"
                                                ? AppTheme.redColor
                                                : AppTheme.blackColor,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Raleway"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          //endIndent: 100,
                          color: AppTheme.primaryColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Business Arabic Name : ",
                            style: TextStyle(
                                color: AppTheme.blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Raleway"),
                            children: <TextSpan>[
                              TextSpan(
                                text: widget.cr.nameArabic,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.blackColor,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Raleway"),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Phone Number : ",
                            style: TextStyle(
                                color: AppTheme.blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Raleway"),
                            children: <TextSpan>[
                              TextSpan(
                                text: widget.cr.phoneNumber,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.blackColor,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Raleway"),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Registration Number : ",
                            style: TextStyle(
                                color: AppTheme.blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Raleway"),
                            children: <TextSpan>[
                              TextSpan(
                                text: widget.cr.registrationNum,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.blackColor,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Raleway"),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Business Address : ",
                            style: TextStyle(
                                color: AppTheme.blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Raleway"),
                            children: <TextSpan>[
                              TextSpan(
                                text: widget.cr.businessAddress,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.blackColor,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Raleway"),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 0.2,
                          indent: 5,
                          endIndent: 100,
                          color: AppTheme.primaryColor,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.pin_drop_sharp,
                              color: AppTheme.primaryColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Business Area : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        for (int i = 0; i < widget.cr.businessAreas.length; i++)
                          RichText(
                            text: TextSpan(
                              text:
                                  "${widget.cr.businessAreas[i].title} ${" : "}",
                              style: TextStyle(
                                  color: AppTheme.blackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Raleway"),
                              children: <TextSpan>[
                                TextSpan(
                                  text: widget.cr.businessAreas[i].value,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: AppTheme.blackColor,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Raleway"),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 0.2,
                          indent: 5,
                          endIndent: 100,
                          color: AppTheme.primaryColor,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.attach_file,
                                  color: AppTheme.primaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Attachement : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.cr.userAttachment.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      widget.cr.certificate[index],
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    )),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.2,
                child: Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.person,
                                color: AppTheme.primaryColor,
                              ),
                              title: RichText(
                                text: TextSpan(
                                  text: "Contact Person  : ",
                                  style: TextStyle(
                                      color: AppTheme.blackColor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Raleway"),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: widget.cr.userName,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: AppTheme.blackColor,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Raleway"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              indent: 10,
                              endIndent: 10,
                              color: AppTheme.primaryColor,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                text: "Name : ",
                                style: TextStyle(
                                    color: AppTheme.blackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Raleway"),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: widget.cr.userName,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.blackColor,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Raleway"),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            RichText(
                              text: TextSpan(
                                text: "Mobile Number : ",
                                style: TextStyle(
                                    color: AppTheme.blackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Raleway"),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: widget.cr.userMobile,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.blackColor,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Raleway"),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            RichText(
                              text: TextSpan(
                                text: "Email : ",
                                style: TextStyle(
                                    color: AppTheme.blackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Raleway"),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: widget.cr.userEmail,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.blackColor,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Raleway"),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            RichText(
                              text: TextSpan(
                                text: "Country : ",
                                style: TextStyle(
                                    color: AppTheme.blackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Raleway"),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: widget.cr.userCountry,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.blackColor,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Raleway"),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            RichText(
                              text: TextSpan(
                                text: "Language : ",
                                style: TextStyle(
                                    color: AppTheme.blackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Raleway"),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: widget.cr.userLanguage,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.blackColor,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Raleway"),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.attach_file,
                                  color: AppTheme.primaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Attachement : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.cr.userAttachment.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          widget.cr.userAttachment[index],
                                          height: 120,
                                          width: 120,
                                          fit: BoxFit.cover,
                                        )),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Send Message"))
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
