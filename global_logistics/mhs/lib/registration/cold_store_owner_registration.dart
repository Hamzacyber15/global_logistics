import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mhs/app_theme.dart';
import 'package:mhs/bottom_bar_screens.dart/bottom_nav_bar.dart';
import 'package:mhs/bottom_bar_screens.dart/home.dart';
import 'package:mhs/constants.dart';
import 'package:mhs/loading_widget.dart';
import 'package:mhs/models/attachment_model.dart';
import 'package:mhs/models/check_box_model.dart';
import 'package:mhs/models/drop_down_menu_model.dart';
import 'package:mhs/models/storage_area_model.dart';
import 'package:mhs/provider/storage_provider.dart';
import 'package:mhs/registration/cold_store_user_registration.dart';
import 'package:mhs/registration/registration_fields.dart';
import 'package:mhs/widgets/check_box_container.dart';
import 'package:mhs/widgets/document_viewer.dart';
import 'package:mhs/widgets/drop_down_menu.dart';
import 'package:mhs/widgets/picker_widget.dart';
import 'package:provider/provider.dart';

class ColdStoreOwnerRegistration extends StatefulWidget {
  const ColdStoreOwnerRegistration({super.key});

  @override
  State<ColdStoreOwnerRegistration> createState() =>
      _ColdStoreOwnerRegistrationState();
}

class _ColdStoreOwnerRegistrationState
    extends State<ColdStoreOwnerRegistration> {
  int count = 0;
  bool loading = false;
  String userSelectedCountry = "";
  String userPreferredLanguage = "";
  String userName = "";
  String userMobile = "";
  String userEmail = "";
  String businessEmail = "";
  String password = "";
  String confirmPassword = "";
  List<String> selectedBlock = [];
  List<String> selectedWholeSaleArea = [""];
  List<String> selectedWholeSaleAreaId = [""];
  List<StorageAreaModel> selectedWholeSaleAreaIdt = [];
  List<String> selectedOnionArea = [""];
  List<String> selectedOnionAreaId = [];
  List<StorageAreaModel> selectedOnionAreaIdt = [];
  List<String> selectedColdStorageArea = [""];
  List<String> selectedColdStorageAreaId = [];
  List<StorageAreaModel> selectedColdAreaIdt = [];
  List<String> selectedPotatoArea = [""];
  List<String> selectedPotatoAreaId = [];
  List<StorageAreaModel> selectedPotatoAreaIdt = [];
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessNameArabicController = TextEditingController();
  TextEditingController businessRegistrationController =
      TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController crNumberController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController wholeSale = TextEditingController();
  TextEditingController coldStorage = TextEditingController();
  TextEditingController onionPotato = TextEditingController();
  TextEditingController truckArea = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  List<TextEditingController> titleControllerList = [];
  List<AttachmentModel> userAttachments = [];
  List<AttachmentModel> attachments = [];
  List<CheckBoxModel> businessList = [
    CheckBoxModel(title: "Whole Sale Area", status: false, value: ""),
    CheckBoxModel(title: "Cold Storage Area", status: false, value: ""),
    CheckBoxModel(title: "Onion Area", status: false, value: ""),
    CheckBoxModel(title: "Potato Area", status: false, value: ""),
    CheckBoxModel(title: "Sell from the truck Area", status: false, value: ""),
  ];
  DropDownMenuDataModel storage = Constants.coldStorageBlock[0];
  List<bool> businessListBool = [
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  void initState() {
    super.initState();
    getDataStorage();
  }

  void onFilesPicked(List<AttachmentModel> files) async {
    setState(() {
      attachments = files;
    });
  }

  void getValues(String type, String value, String id, int i) {
    if (type == "block") {
      //selectedBlock[i] = value;
      // selectedBlock[i] = value;
      Provider.of<StorageProvider>(context, listen: false)
          .getColdStorageBlock(value);
    } else if (type == "coldStorage") {
      // selectedColdStorageArea[i] = value;
      // selectedColdStorageAreaId[i] = id;
      selectedColdAreaIdt.insert(
          i, StorageAreaModel(id: id, storage: value, status: ""));
    } else if (type == "onionShade") {
      // selectedOnionArea[i] = value;
      // selectedOnionAreaId[i] = id;
      selectedOnionAreaIdt.insert(
          i, StorageAreaModel(id: id, storage: value, status: ""));
    } else if (type == "potatoShade") {
      // selectedPotatoArea[i] = value;
      // selectedPotatoAreaId[i] = id;
      selectedPotatoAreaIdt.insert(
          i, StorageAreaModel(id: id, storage: value, status: ""));
    } else if (type == "wholeSale") {
      //   selectedColdStorageArea[i] = value;
      selectedWholeSaleAreaIdt.insert(
          i, StorageAreaModel(id: id, storage: value, status: ""));
      // selectedColdStorageAreaId.insert(
      //   i,
      //   id,
      // );
      // selectedWholeSaleArea.insert(i, value);
    }
  }

  void getData(int i, Function f) {}

  void getColdStorage() {}

  @override
  void dispose() {
    crNumberController.dispose();
    numController.dispose();
    wholeSale.dispose();
    coldStorage.dispose();
    onionPotato.dispose();
    truckArea.dispose();
    nameController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  void register() {
    setState(() {
      loading = true;
    });
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: businessEmail,
      password: password,
    )
        .then((value) {
      setState(() {
        loading = false;
        count += 1;
      });
    }).catchError((onError) {
      Constants.showMessage(context, onError.message.toString());
    });
  }

  void checkCredentials() {
    if (loading) {
      return;
    }
    if (businessEmail.isEmpty) {
      Constants.showMessage(context, "Please enter your your Email Address");
    } else if (password.isEmpty) {
      Constants.showMessage(context, "Please enter your Password");
    } else if (password != confirmPassword) {
      Constants.showMessage(context, "Passwords do not match");
    } else {
      register();
    }
  }

  void parseData(
      TextEditingController email,
      TextEditingController passwordBusiness,
      TextEditingController confirmPasswordBusiness) {
    businessEmail = email.text.trim();
    password = passwordBusiness.text.trim();
    confirmPassword = confirmPasswordBusiness.text.trim();
  }

  void tapped(String contentType, String url) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return DocumentViewer(
        contentType,
        url,
      );
    }));
  }

  bool checkBusinessCredentials() {
    bool result = false;
    if (businessNameController.text.trim().isEmpty) {
      Constants.showMessage(context, "Please Enter Business Name In English");
    } else if (businessNameArabicController.text.trim().isEmpty) {
      Constants.showMessage(context, "Please Enter Business Name In Arabic");
    } else if (businessRegistrationController.text.trim().isEmpty) {
      Constants.showMessage(
          context, "Please Enter Business Registration Number");
    } else if (phoneController.text.trim().isEmpty) {
      Constants.showMessage(context, "Please Enter Phone Number");
    } else if (businessAddressController.text.trim().isEmpty) {
      Constants.showMessage(context, "Please Enter Company Address");
    } else {
      result = true;
    }
    return result;
  }

  bool checkBusinessList() {
    bool result = true;
    // bool hasTrueStatus = businessList.any((element) => element.status);
    // if (!hasTrueStatus) {
    //   Constants.showMessage(
    //       context, "Please Select At least One Business Area");
    // } else {
    //   for (var element in businessList) {
    //     if (element.status) {
    //       if (element.value.isEmpty) {
    //         Constants.showMessage(
    //             context, "${"Please Mention"} ${element.title}");
    //       } else {
    //         result = true;
    //       }
    //     }
    //   }
    // }

    return result;
  }

  bool checkUserCredentials() {
    bool result = false;
    if (userName.isEmpty) {
      Constants.showMessage(context, "Please Add User Name");
    } else if (userMobile.isEmpty) {
      Constants.showMessage(context, "Please Enter User Mobile Number");
    } else if (userEmail.isEmpty) {
      Constants.showMessage(context, "Please Enter User Email");
    } else if (userSelectedCountry.isEmpty) {
      Constants.showMessage(context, "Please Select User Country");
    } else if (userPreferredLanguage.isEmpty) {
      Constants.showMessage(context, "please Select User Preffered Country");
    } else if (userAttachments.isEmpty) {
      Constants.showMessage(context, "Please Attach ID/Passport Pictures");
    } else {
      result = true;
    }
    return result;
  }

  void message(String title) {
    Constants.showMessage(context, title);
  }

  void registerBusiness() async {
    if (loading) {
      return;
    }
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    List<String> userUrls = [];
    for (AttachmentModel attachment in userAttachments) {
      String url = await Constants.uploadAttachment(attachment);
      userUrls.add(url);
    }
    if (userUrls.length < 2) {
      message(
          "Please At least Upload (2 Photos) i.e. Front & Backside of Card");
      return;
    }
    List<String> urls = [];
    for (AttachmentModel attachment in attachments) {
      String url = await Constants.uploadAttachment(attachment);
      urls.add(url);
    }
    List<dynamic> selectedBusinessList = [];
    for (var element in selectedColdAreaIdt) {
      selectedBusinessList.add({
        'title': "Cold Storage",
        "storage": element.storage,
        'id': element.id,
      });
    }
    for (var element in selectedOnionAreaIdt) {
      selectedBusinessList.add({
        'title': "Onion Shade",
        "storage": element.storage,
        'id': element.id,
      });
    }
    for (var element in selectedPotatoAreaIdt) {
      selectedBusinessList.add({
        'title': "Potato Shade",
        "storage": element.storage,
        'id': element.id,
      });
    }
    for (var element in selectedWholeSaleAreaIdt) {
      selectedBusinessList.add({
        'title': "Whole Sale",
        "storage": element.storage,
        'id': element.id,
      });
    }

    setState(() {
      loading = true;
    });
    WriteBatch batch = FirebaseFirestore.instance.batch();
    try {
      String businessId =
          FirebaseFirestore.instance.collection('business').doc().id;
      batch.set(
          FirebaseFirestore.instance.collection('business').doc(businessId),
          {
            'userId': user.uid,
            'nameEnglish': businessNameController.text.trim(),
            'nameArabic': businessNameArabicController.text.trim(),
            'registrationNum': businessRegistrationController.text.trim(),
            'phoneNumber': phoneController.text.trim(),
            'businessAddress': businessAddressController.text.trim(),
            'certificate': urls,
            'businessAreas': selectedBusinessList,
            'userName': userName,
            'userMobile': userMobile,
            'userEmail': userEmail,
            'userCountry': userSelectedCountry,
            'userLanguage': userPreferredLanguage,
            'userAttachment': userUrls,
            "status": "pending",
          },
          SetOptions(merge: true));
      batch.set(
        FirebaseFirestore.instance.collection('profile').doc(user.uid),
        {
          "userRole": "business",
          "timestamp": Timestamp.now(),
          'businessId': businessId,
          'businessEmail': businessEmail,
          'userEmail': userEmail,
          'userName': userName,
          'userMobile': userMobile,
          'userCountry': userSelectedCountry,
          'userLanguage': userPreferredLanguage,
          'userAttachment': userUrls,
        },
        SetOptions(merge: true),
      );
      await batch.commit().then((value) {
        // Navigator.of(context).pop();
        navHome();
        Constants.showMessage(context, "Request Sent");
      }).catchError((onError) {
        Constants.showMessage(context, onError.toString());
      });
      // await FirebaseFirestore.instance.collection('business').add({
      //   'userId': user.uid,
      //   'nameEnglish': businessNameController.text.trim(),
      //   'nameArabic': businessNameArabicController.text.trim(),
      //   'registrationNum': businessRegistrationController.text.trim(),
      //   'phoneNumber': phoneController.text.trim(),
      //   'businessAddress': businessAddressController.text.trim(),
      //   'certificate': urls,
      //   'businessAreas': selectedBusinessList,
      //   'userName': userName,
      //   'userMobile': userMobile,
      //   'userEmail': userEmail,
      //   'userCountry': userSelectedCountry,
      //   'userLanguage': userPreferredLanguage,
      //   'userAttachment': userUrls,
      //   "status": "pending",
      // }).then((value) {
      //   Constants.showMessage(context, "Registration Request Sent");
      //   navHome();
      // });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  void navHome() {
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (_) {
          return const BottomNavBar();
        },
      ), (route) => false);
    }
  }

  void getUserData(String name, String mobile, String emailAdress,
      String country, String language, List<AttachmentModel> aList) {
    userName = name;
    userMobile = mobile;
    userEmail = emailAdress;
    userSelectedCountry = country;
    userPreferredLanguage = language;
    userAttachments = aList;
  }

  void next(String type) {
    bool checkBusiness = false;
    if (type == "next") {
      if (count == 0) {
        checkCredentials();
      } else if (count == 1) {
        bool check = checkBusinessCredentials();
        if (!check) {
          return;
        } else {
          checkBusiness = checkBusinessList();
          if (!checkBusiness) {
            return;
          }
          // else {
          //   if (attachments.isEmpty) {
          //     Constants.showMessage(
          //         context, "Please Upload Registration Documents");
          //     return;
          //   }
          else {
            setState(() {
              count += 1;
            });
            //}
          }
        }
      } else if (count == 2) {
        bool checkUser = checkUserCredentials();
        if (!checkUser) {
          return;
        } else {
          registerBusiness();
        }
      }
    } else {
      if (count != 0) {
        setState(() {
          count -= 1;
        });
      }
    }
  }

  void getCheckBoxData(CheckBoxModel cm, int i) {
    businessList[i] = cm;
  }

  void changeStatus(int i) {
    businessListBool[i] = !businessListBool[i];
    if (businessListBool[0]) {
      Provider.of<StorageProvider>(context, listen: false)
          .getWholeSaleArea("wholeSale");
    } else if (businessListBool[2]) {
      Provider.of<StorageProvider>(context, listen: false)
          .getWholeSaleArea("onionShade");
    } else if (businessListBool[3]) {
      Provider.of<StorageProvider>(context, listen: false)
          .getWholeSaleArea("potatoShade");
    }
    setState(() {});
  }

  void getDataStorage() {
    Provider.of<StorageProvider>(context, listen: false)
        .getWholeSaleArea("wholeSale");

    Provider.of<StorageProvider>(context, listen: false)
        .getWholeSaleArea("onionShade");

    Provider.of<StorageProvider>(context, listen: false)
        .getWholeSaleArea("potatoShade");
  }

  void addRow(int i) {
    if (i == 2) {
      selectedOnionArea.add("");
    } else if (i == 0) {
      selectedWholeSaleArea.add("");
    } else if (i == 1) {
      selectedColdStorageArea.add("");
    } else if (i == 3) {
      selectedPotatoArea.add("");
    }
    setState(() {});
  }

  void deleteRow(int businessInt, int rowInt) {
    if (businessInt == 2) {
      if (selectedOnionArea.length != 1) {
        selectedOnionArea.removeAt(rowInt);
        // selectedOnionAreaIdt.removeAt(rowInt);
      }
    } else if (businessInt == 0) {
      if (selectedWholeSaleArea.length != 1) {
        selectedWholeSaleArea.removeAt(rowInt);
        //selectedWholeSaleAreaIdt.removeAt(rowInt);
      }
    } else if (businessInt == 1) {
      if (selectedColdStorageArea.length != 1) {
        selectedColdStorageArea.removeAt(rowInt);
        //selectedColdAreaIdt.removeAt(rowInt);
      }
    } else if (businessInt == 3) {
      if (selectedPotatoArea.length != 1) {
        selectedPotatoArea.removeAt(rowInt);
        //selectedPotatoAreaIdt.removeAt(rowInt);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final wholeSale = Provider.of<StorageProvider>(context).wholeSaleArea;
    final coldStorage = Provider.of<StorageProvider>(context).coldStorageArea;
    final onionStorage = Provider.of<StorageProvider>(context).onionArea;
    final potatoStorage = Provider.of<StorageProvider>(context).potatoArea;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: count == 2 ? true : false,
        leading: count == 2
            ? IconButton(
                onPressed: () => next("back"),
                icon: const Icon(Icons.arrow_back))
            : null,
        title: const Text("Seller Registration"),
      ),
      body: loading
          ? const LoadingWidget()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: 300,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/logo.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    // Text(
                    //   "Business Registration",
                    //   style: TextStyle(
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.bold,
                    //       color: AppTheme.primaryColor),
                    // ),
                    // const Text(
                    //   "Steps",
                    //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     for (int i = 1; i < 4; i++)
                    //       GestureDetector(
                    //         onTap: () {
                    //           if (count < i) {
                    //             count += 1;
                    //           } else {
                    //             count -= 1;
                    //           }
                    //           setState(() {
                    //             count = i;
                    //           });
                    //         },
                    //         child: CircleAvatar(
                    //           radius: 28,
                    //           backgroundColor: count + 1 == i
                    //               ? AppTheme.primaryColor
                    //               : AppTheme.whiteColor,
                    //           child: Text(
                    //             i.toString(),
                    //             style: TextStyle(
                    //                 color: count + 1 == i
                    //                     ? AppTheme.whiteColor
                    //                     : AppTheme.primaryColor,
                    //                 fontWeight: FontWeight.bold),
                    //           ),
                    //         ),
                    //       ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    IndexedStack(
                      index: count,
                      children: [
                        RegistrationFields(
                          getData: parseData,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Card(
                              child: TextField(
                                controller: businessNameController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.abc,
                                    color: Colors.black,
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
                                  labelText: "Commercial Name In English",
                                ),
                                cursorColor: AppTheme.primaryColor,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () {
                                  FocusScope.of(context).nextFocus();
                                },
                              ),
                            ),
                            Card(
                              child: TextField(
                                controller: businessNameArabicController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.translate,
                                    color: Colors.black,
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
                                  labelText: "Commercial Name In Arabic",
                                ),
                                cursorColor: AppTheme.primaryColor,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () {
                                  FocusScope.of(context).nextFocus();
                                },
                              ),
                            ),
                            Card(
                              child: TextField(
                                controller: businessRegistrationController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.info,
                                    color: Colors.black,
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
                                  labelText: "Company Registration No* ",
                                ),
                                cursorColor: AppTheme.primaryColor,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () {
                                  FocusScope.of(context).nextFocus();
                                },
                              ),
                            ),
                            //phoneNumberField(context),

                            Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "+968",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: AppTheme.orangeColor),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 30,
                                      width: 2,
                                      color:
                                          AppTheme.blackColor.withOpacity(0.5),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: phoneController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: const InputDecoration(
                                          // prefixIcon: Icon(
                                          //   Icons.info,
                                          //   color: Colors.black,
                                          // ),
                                          contentPadding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          labelText: "Phone Number ",
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
                                controller: businessAddressController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.info,
                                    color: AppTheme.orangeColor,
                                  ),
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  labelText: "Company Address* ",
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Select Warehouse Details",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    for (int i = 0;
                                        i < businessList.length;
                                        i++)
                                      Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              //
                                              CheckBoxContainer(
                                                check: businessListBool[i],
                                                tapped: () => changeStatus(i),
                                                title: businessList[i].title,
                                                iconImage:
                                                    "assets/images/warehouse_building.png",
                                              ),
                                              if (businessListBool[0] && i == 0)
                                                for (int a = 0;
                                                    a <
                                                        selectedWholeSaleArea
                                                            .length;
                                                    a++)
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Card(
                                                          color: AppTheme
                                                              .primaryColor
                                                              .withOpacity(0.1),
                                                          child: DropDownMenu(
                                                            getValues,
                                                            "Whole Sale Area",
                                                            icon:
                                                                'assets/images/warehouse.png',
                                                            wholeSale,
                                                            Constants.a,
                                                            "wholeSale",
                                                            showBorder: true,
                                                            index: a,
                                                          ),
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () =>
                                                            deleteRow(i, a),
                                                        icon: const Icon(
                                                            Icons.delete),
                                                        color:
                                                            AppTheme.redColor,
                                                      ),
                                                    ],
                                                  ),
                                              if (businessListBool[1] && i == 1)
                                                for (int b = 0;
                                                    b <
                                                        selectedColdStorageArea
                                                            .length;
                                                    b++)
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () =>
                                                            deleteRow(i, b),
                                                        icon: const Icon(
                                                            Icons.delete),
                                                        color:
                                                            AppTheme.redColor,
                                                      ),
                                                      Card(
                                                        color: AppTheme
                                                            .primaryColor
                                                            .withOpacity(0.1),
                                                        child: DropDownMenu(
                                                          getValues,
                                                          "Block",
                                                          icon:
                                                              'assets/images/warehouse.png',
                                                          Constants
                                                              .coldStorageBlock,
                                                          storage,
                                                          "block",
                                                          showBorder: true,
                                                          index: b,
                                                        ),
                                                      ),
                                                      // if (selectedBlock
                                                      //     .isNotEmpty)
                                                      Card(
                                                        color: AppTheme
                                                            .primaryColor
                                                            .withOpacity(0.1),
                                                        child: DropDownMenu(
                                                          getValues,
                                                          "Cold Storage",
                                                          icon:
                                                              'assets/images/warehouse.png',
                                                          coldStorage,
                                                          Constants.a,
                                                          "coldStorage",
                                                          showBorder: true,
                                                          index: b,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                              if (businessListBool[2] && i == 2)
                                                for (int j = 0;
                                                    j <
                                                        selectedOnionArea
                                                            .length;
                                                    j++)
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Card(
                                                          color: AppTheme
                                                              .primaryColor
                                                              .withOpacity(0.1),
                                                          child: DropDownMenu(
                                                            getValues,
                                                            "Onion Shade",
                                                            icon:
                                                                'assets/images/warehouse.png',
                                                            onionStorage,
                                                            Constants.a,
                                                            "onionShade",
                                                            showBorder: true,
                                                            index: j,
                                                          ),
                                                        ),
                                                      ),
                                                      // const SizedBox(
                                                      //   width: 5,
                                                      // ),
                                                      IconButton(
                                                        onPressed: () =>
                                                            deleteRow(i, j),
                                                        icon: const Icon(
                                                            Icons.delete),
                                                        color:
                                                            AppTheme.redColor,
                                                      ),
                                                      // Icon(
                                                      //   Icons.delete,
                                                      //   color:
                                                      //       AppTheme.redColor,
                                                      // ),
                                                    ],
                                                  ),
                                              if (businessListBool[3] && i == 3)
                                                for (int z = 0;
                                                    z <
                                                        selectedPotatoArea
                                                            .length;
                                                    z++)
                                                  Card(
                                                    color: AppTheme.primaryColor
                                                        .withOpacity(0.1),
                                                    child: DropDownMenu(
                                                      getValues,
                                                      "Potato Shade",
                                                      icon:
                                                          'assets/images/warehouse.png',
                                                      potatoStorage,
                                                      Constants.a,
                                                      "potatoShade",
                                                      showBorder: true,
                                                      index: z,
                                                    ),
                                                  ),
                                              if (businessListBool[i])
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              if (businessListBool[i])
                                                GestureDetector(
                                                  onTap: () => addRow(i),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Icon(
                                                        Icons.add_box,
                                                        color: AppTheme
                                                            .primaryColor,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        "Add More",
                                                        style: TextStyle(
                                                            color: AppTheme
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                )

                                              // CheckBoxListTileContainer(
                                              //   cm: businessList[i],
                                              //   parseData: getCheckBoxData,
                                              //   index: i,
                                              // )
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Company Registration Certificate* ",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            PickerWidget(
                              cameraAllowed: false,
                              galleryAllowed: false,
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
                                          width: 1,
                                          color: AppTheme.primaryColor
                                              .withOpacity(0.5)),
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppTheme.whiteColor),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                height: 200,
                                child: ListView.builder(
                                  //scrollDirection: Axis.horizontal,
                                  itemCount: attachments.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: ListTile(
                                        title: Text(attachments[index].name),
                                      ),
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                        ColdStoreUserRegistration(
                          parseData: getUserData,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
        child: ElevatedButton(
          onPressed: () => next("next"), //count == 0 ? register : null,
          child: count == 2
              ? const Text(
                  'Register',
                )
              : const Text(
                  'Next',
                ),
        ),
      ),
    );
  }
}
