import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/constants.dart';
import 'package:mhs/models/attachment_model.dart';
import 'package:mhs/models/drop_down_menu_model.dart';
import 'package:mhs/widgets/drop_down_menu.dart';
import 'package:mhs/widgets/picker_widget.dart';

class ColdStoreUserRegistration extends StatefulWidget {
  final Function parseData;
  const ColdStoreUserRegistration({required this.parseData, super.key});

  @override
  State<ColdStoreUserRegistration> createState() =>
      _ColdStoreUserRegistrationState();
}

class _ColdStoreUserRegistrationState extends State<ColdStoreUserRegistration> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  DropDownMenuDataModel language = Constants.languageList[0];
  DropDownMenuDataModel countries = Constants.countries[0];
  List<AttachmentModel> attachments = [];
  String countryCode = "+968";
  bool cont = false;
  String phoneNumber = "";
  String selectedCountry = "";
  String selectedlanguage = "";

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    userEmailController.dispose();
    super.dispose();
  }

  void getValues(String type, String value, String id) {
    if (type == "language") {
      selectedlanguage = value;
    } else {
      selectedCountry = value;
    }

    sendData();
  }

  void onFilesPicked(List<AttachmentModel> files) {
    setState(() {
      attachments = files;
    });
    sendData();
  }

  void sendData() {
    String name = nameController.text.trim();
    String mobile = mobileController.text.trim();
    String email = userEmailController.text.trim();
    widget.parseData(
        name, mobile, email, selectedCountry, selectedlanguage, attachments);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          child: TextField(
            onChanged: (value) {
              sendData();
            },
            controller: nameController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.abc,
                color: Colors.black,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 5),
              labelText: "Name",
            ),
            cursorColor: AppTheme.primaryColor,
            textInputAction: TextInputAction.next,
            onEditingComplete: () {
              FocusScope.of(context).nextFocus();
            },
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "+968",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppTheme.blackColor.withOpacity(0.5)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 30,
                  width: 2,
                  color: AppTheme.blackColor.withOpacity(0.5),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      sendData();
                    },
                    controller: mobileController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      // prefixIcon: Icon(
                      //   Icons.info,
                      //   color: Colors.black,
                      // ),
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      labelText: "Mobile Number ",
                    ),
                    cursorColor: AppTheme.primaryColor,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: TextField(
            onChanged: (value) {
              sendData();
            },
            controller: userEmailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 5),
              labelText: "Email Address",
            ),
            cursorColor: AppTheme.primaryColor,
            textInputAction: TextInputAction.next,
            onEditingComplete: () {
              FocusScope.of(context).nextFocus();
            },
          ),
        ),
        //phoneNumberField(context),
        Row(
          children: [
            Expanded(
              child: Card(
                child: DropDownMenu(
                    getValues,
                    "Select Country",
                    //const Icon(Icons.translate),
                    Constants.countries,
                    language,
                    "country"),
              ),
            ),
            Expanded(
              child: Card(
                child: DropDownMenu(
                    getValues,
                    "Preffered Language",
                    //   const Icon(Icons.translate),
                    Constants.languageList,
                    language,
                    "language"),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Upload ID Card On Both Side",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        PickerWidget(
          cameraAllowed: true,
          galleryAllowed: true,
          videoAllowed: false,
          filesAllowed: true,
          multipleAllowed: true,
          memoAllowed: false,
          attachments: attachments,
          onFilesPicked: onFilesPicked,
          captionAllowed: false,
          child: Card(
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1, color: AppTheme.primaryColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(12),
                  color: AppTheme.whiteColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.upload_file_sharp,
                    size: 40,
                    color: AppTheme.primaryColor,
                  ),
                  Text(
                    "Select files to upload",
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (attachments.isNotEmpty)
          SizedBox(
            height: 150,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: attachments.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: attachments[index].url.isNotEmpty
                          ? Image.file(
                              File(attachments[index].url),
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            )
                          : Image.memory(
                              attachments[index].bytes!,
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            )),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget phoneNumberField(context) {
    return ListTile(
      tileColor: AppTheme.whiteColor,
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 72,
      leading: Container(
        height: 52,
        width: 72,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppTheme.greyColor,
        ),
        child: CountryCodePicker(
          showFlagMain: false,
          showFlagDialog: false,
          hideSearch: false,
          padding: EdgeInsets.zero,
          dialogSize: const Size(
            300,
            50,
          ),
          barrierColor: AppTheme.blackColor.withOpacity(0.1),
          onChanged: (cc) {
            setState(() {
              countryCode = cc.dialCode!;
            });
          },
          showFlag: false,
          searchStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.blackColor,
          ),
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.blackColor,
          ),
          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
          initialSelection: 'US',
          // ignore: prefer_const_literals_to_create_immutables
          favorite: ['+1', 'US'],
          // optional. Shows only country name and flag
          showCountryOnly: false,
          // optional. Shows only country name and flag when popup is closed.
          showOnlyCountryWhenClosed: false,
          // optional. aligns the flag and the Text left
          alignLeft: false,
        ),
      ),
      title: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        // child: TextFormField(
        //   controller: mobileController,
        //   cursorColor: AppTheme.greenColor,
        //   keyboardType: TextInputType.phone,
        //   onChanged: (phone) {
        //     setState(() {
        //       phone.length > 9 ? cont = true : cont = false;
        //       phoneNumber = phone;
        //     });
        //   },
        //   style: const TextStyle(
        //     fontSize: 14,
        //     fontWeight: FontWeight.w500,
        //     //color: const Color(0xffABAEB9).withOpacity(0.40),
        //   ),
        //   decoration: InputDecoration(
        //     contentPadding: const EdgeInsets.symmetric(
        //       horizontal: 15,
        //       vertical: 15,
        //     ),
        //     filled: true,
        //     fillColor: AppTheme.greyColor,
        //     hintText: 'Phone Number',
        //     hintStyle: const TextStyle(
        //       fontSize: 14,
        //       fontWeight: FontWeight.w500,
        //       color: Color(0xffABAEB9),
        //     ),
        //     suffixIcon: const Icon(Icons.mobile_friendly),
        //     border: InputBorder.none,
        //     enabledBorder: InputBorder.none,
        //     focusedBorder: InputBorder.none,
        //   ),
        // ),
      ),
    );
  }
}
